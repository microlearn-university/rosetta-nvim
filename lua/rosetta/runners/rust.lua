-- Rust runner: rustc --test + binary execution, with JSON diagnostics.
-- Adapted from ferris.nvim.

local M = {}

function M.edit_file(work_dir)
  return work_dir .. '/solution.rs'
end

local function parse_json_lines(lines)
  local parsed = {}
  for _, line in ipairs(lines) do
    if line ~= '' then
      local ok, obj = pcall(vim.json.decode, line)
      if ok and type(obj) == 'table' and type(obj.message) == 'string' then
        table.insert(parsed, obj)
      end
    end
  end
  return parsed
end

local function parse_errors(lines)
  local diags = {}
  for _, obj in ipairs(parse_json_lines(lines)) do
    local level = obj.level or ''
    local sev = level == 'error'   and vim.diagnostic.severity.ERROR
             or level == 'warning' and vim.diagnostic.severity.WARN
             or vim.diagnostic.severity.HINT
    for _, span in ipairs(obj.spans or {}) do
      if span.is_primary then
        table.insert(diags, {
          lnum     = span.line_start - 1,
          col      = span.column_start - 1,
          end_lnum = span.line_end - 1,
          end_col  = span.column_end - 1,
          severity = sev,
          message  = obj.message,
          source   = 'rustc',
        })
      end
    end
  end
  return diags
end

local function first_compile_error(lines)
  local count, first = 0, nil
  for _, obj in ipairs(parse_json_lines(lines)) do
    if obj.level == 'error' and not obj.message:match('^aborting due to') then
      count = count + 1
      if not first then
        local code = type(obj.code) == 'table' and obj.code.code
        first = code
          and ('error[' .. code .. ']: ' .. obj.message)
          or  ('error: ' .. obj.message)
      end
    end
  end
  if not first then return 'Compilation failed' end
  return count > 1
    and (first .. string.format('  (+%d more)', count - 1))
    or   first
end

local function summarise_test_output(lines)
  for _, l in ipairs(lines) do
    if l:match('^test result') then return l end
  end
  for _, l in ipairs(lines) do
    if l:match('panicked') then
      if l:match('not yet implemented') then
        return 'Implement the function — todo!() was reached'
      end
      return l:match("'(.-)'") or l
    end
  end
  return table.concat(lines, ' '):sub(1, 160)
end

function M.check(work_dir, callback)
  if vim.fn.executable('rustc') == 0 then
    callback(false, {}, 'rustc not found — is Rust installed?')
    return
  end

  local filepath = work_dir .. '/solution.rs'
  local bin = vim.fn.tempname()
  local errors = {}
  local done, timed_out = false, false
  local job_id

  job_id = vim.fn.jobstart(
    { 'rustc', '--edition', '2021', '--test', '--error-format=json', '-o', bin, filepath },
    {
      stderr_buffered = true,
      on_stderr = function(_, data)
        for _, l in ipairs(data or {}) do
          if l ~= '' then table.insert(errors, l) end
        end
      end,
      on_exit = function(_, code)
        if done then return end
        if timed_out then
          done = true
          vim.fn.delete(bin)
          vim.schedule(function()
            callback(false, {}, 'timed out after 15s — possible infinite loop')
          end)
          return
        end
        if code ~= 0 then
          done = true
          local diags = parse_errors(errors)
          local msg   = first_compile_error(errors)
          vim.schedule(function() callback(false, diags, msg) end)
          return
        end

        local out = {}
        job_id = vim.fn.jobstart({ bin }, {
          stdout_buffered = true,
          stderr_buffered = true,
          on_stdout = function(_, data)
            for _, l in ipairs(data or {}) do
              if l ~= '' then table.insert(out, l) end
            end
          end,
          on_stderr = function(_, data)
            for _, l in ipairs(data or {}) do
              if l ~= '' then table.insert(out, l) end
            end
          end,
          on_exit = function(_, test_code)
            if done then return end
            done = true
            vim.fn.delete(bin)
            vim.schedule(function()
              if timed_out then
                callback(false, {}, 'timed out after 15s — possible infinite loop')
                return
              end
              if test_code == 0 then
                callback(true, {}, 'All tests pass!')
              else
                callback(false, {}, summarise_test_output(out))
              end
            end)
          end,
        })
      end,
    }
  )

  if job_id and job_id > 0 then
    vim.defer_fn(function()
      if done then return end
      timed_out = true
      pcall(vim.fn.jobstop, job_id)
    end, 15000)
  end
end

return M
