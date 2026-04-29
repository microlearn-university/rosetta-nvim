-- Python runner: execute `python3 solution.py` — the stub's unittest.main()
-- runs when the file is executed as __main__. Exit 0 = pass.

local M = {}

function M.edit_file(work_dir)
  return work_dir .. '/solution.py'
end

-- Parse a Python traceback into a single inline diagnostic on the deepest
-- user-code frame, plus a short message summary.
local function parse_output(lines, filepath)
  local diags = {}
  local msg_from_traceback = nil
  -- Walk from the end for the final exception message
  for i = #lines, 1, -1 do
    local l = lines[i]
    if l and l:match('^%w[%w_.]*Error') or l:match('^%w[%w_.]*Exception') or l:match('^AssertionError') then
      msg_from_traceback = l
      break
    end
  end
  -- Find the deepest frame pointing at our file
  local last_line_for_file = nil
  for _, l in ipairs(lines) do
    local line_no = l:match('File "' .. vim.pesc(filepath) .. '", line (%d+)')
    if line_no then last_line_for_file = tonumber(line_no) end
  end
  if last_line_for_file and msg_from_traceback then
    table.insert(diags, {
      lnum     = last_line_for_file - 1,
      col      = 0,
      severity = vim.diagnostic.severity.ERROR,
      message  = msg_from_traceback,
      source   = 'python',
    })
  end
  return diags, msg_from_traceback
end

-- Look for unittest's "FAILED (…)" / "OK" summary line.
local function summary_line(lines)
  for i = #lines, 1, -1 do
    local l = lines[i]
    if l and (l:match('^FAILED') or l:match('^OK$') or l:match('^Ran %d')) then
      return l
    end
  end
  return nil
end

function M.check(work_dir, callback)
  local py = vim.fn.executable('python3') == 1 and 'python3'
    or vim.fn.executable('python') == 1 and 'python' or nil
  if not py then
    callback(false, {}, 'python3 not found in PATH')
    return
  end

  local filepath = work_dir .. '/solution.py'
  local out = {}
  local done, timed_out = false, false

  local job_id = vim.fn.jobstart({ py, filepath }, {
    cwd             = work_dir,
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
    on_exit = function(_, code)
      if done then return end
      done = true
      vim.schedule(function()
        if timed_out then
          callback(false, {}, 'timed out after 15s — possible infinite loop')
          return
        end
        if code == 0 then
          callback(true, {}, summary_line(out) or 'All tests pass!')
          return
        end
        local diags, tb_msg = parse_output(out, filepath)
        local summary = summary_line(out)
        local msg = summary or tb_msg or 'Tests failed'
        callback(false, diags, msg)
      end)
    end,
  })

  if job_id > 0 then
    vim.defer_fn(function()
      if done then return end
      timed_out = true
      pcall(vim.fn.jobstop, job_id)
    end, 15000)
  end
end

return M
