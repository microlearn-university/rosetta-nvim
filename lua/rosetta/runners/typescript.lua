-- TypeScript runner: `node --experimental-strip-types --test solution.ts`
-- Requires Node 22.6+. Exit 0 = pass.

local M = {}

function M.edit_file(work_dir)
  return work_dir .. '/solution.ts'
end

-- Parse node:test spec-reporter output for failure location on solution.ts.
-- Stack traces include lines like "at <anon> (solution.ts:12:9)".
local function parse_output(lines)
  local diags = {}
  local first_msg = nil
  for _, l in ipairs(lines) do
    -- node:test failure header: "✖ test_name (..ms)" then detail lines follow
    if not first_msg then
      local fail = l:match('^%s*✖%s+(.+)$') or l:match('^%s*✖ failing tests:%s*$') and nil
      if fail then first_msg = 'failing: ' .. fail end
    end
    -- Stack frame pointing at solution.ts
    local ln, col = l:match('solution%.ts:(%d+):(%d+)')
    if ln and #diags == 0 then
      table.insert(diags, {
        lnum     = tonumber(ln) - 1,
        col      = tonumber(col) - 1,
        severity = vim.diagnostic.severity.ERROR,
        message  = first_msg or 'test failed',
        source   = 'node:test',
      })
    end
    -- Explicit Error messages
    if not first_msg then
      local err = l:match('^%s*Error:%s*(.+)$') or l:match('^%s*AssertionError[^:]*:%s*(.+)$')
      if err then first_msg = err end
    end
  end
  return diags, first_msg
end

function M.check(work_dir, callback)
  if vim.fn.executable('node') == 0 then
    callback(false, {}, 'node not found in PATH (Node 22.6+ required)')
    return
  end

  local filepath = work_dir .. '/solution.ts'
  local out = {}
  local done, timed_out = false, false

  local job_id = vim.fn.jobstart({
    'node', '--experimental-strip-types', '--no-warnings', '--test', filepath,
  }, {
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
          callback(true, {}, 'All tests pass!')
          return
        end
        local diags, msg = parse_output(out)
        callback(false, diags, msg or 'Tests failed')
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
