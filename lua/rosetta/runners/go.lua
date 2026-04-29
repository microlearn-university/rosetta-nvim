-- Go runner: `go test -json .` inside the working directory (which has
-- go.mod + solution.go + solution_test.go). Parses JSON events for diagnostics.

local M = {}

function M.edit_file(work_dir)
  return work_dir .. '/solution.go'
end

-- Extract "file:line: message" style errors from output lines.
-- Matches compiler errors (./solution.go:12:5: ...) and t.Fatalf frames.
local function extract_diag(line, filepath_basename)
  -- compile errors: ./solution.go:12:5: some message
  local file, ln, col, rest = line:match('%.?/?([%w_.]+%.go):(%d+):(%d+):%s*(.*)$')
  if file and rest then
    return { file = file, line = tonumber(ln), col = tonumber(col), msg = rest }
  end
  -- test failure frames: solution_test.go:23: got 0, want 2
  local file2, ln2, rest2 = line:match('([%w_.]+%.go):(%d+):%s*(.*)$')
  if file2 and rest2 then
    return { file = file2, line = tonumber(ln2), col = 0, msg = rest2 }
  end
  return nil
end

-- Parse `go test -json` output: one JSON object per line.
-- Relevant events have Action in {"output", "fail"}.
local function parse_json_events(stdout_lines)
  local msgs = {}
  for _, line in ipairs(stdout_lines) do
    if line ~= '' then
      local ok, obj = pcall(vim.json.decode, line)
      if ok and type(obj) == 'table' then
        if obj.Action == 'output' and type(obj.Output) == 'string' then
          for piece in obj.Output:gmatch('[^\n]+') do
            table.insert(msgs, piece)
          end
        end
      end
    end
  end
  return msgs
end

function M.check(work_dir, callback)
  if vim.fn.executable('go') == 0 then
    callback(false, {}, 'go not found in PATH')
    return
  end

  local stdout = {}
  local stderr = {}
  local done, timed_out = false, false

  local job_id = vim.fn.jobstart({ 'go', 'test', '-json', '.' }, {
    cwd             = work_dir,
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      for _, l in ipairs(data or {}) do
        if l ~= '' then table.insert(stdout, l) end
      end
    end,
    on_stderr = function(_, data)
      for _, l in ipairs(data or {}) do
        if l ~= '' then table.insert(stderr, l) end
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

        -- Compile errors arrive on stderr OR in JSON-wrapped stdout events.
        local candidate_lines = {}
        for _, l in ipairs(stderr) do table.insert(candidate_lines, l) end
        for _, l in ipairs(parse_json_events(stdout)) do
          table.insert(candidate_lines, l)
        end

        -- Inline diagnostics only for errors in solution.go (the edited buffer).
        -- Errors in solution_test.go surface as the echo message only.
        local diags = {}
        local first_msg = nil
        for _, l in ipairs(candidate_lines) do
          local d = extract_diag(l)
          if d then
            first_msg = first_msg or (d.file .. ':' .. d.line .. ': ' .. d.msg)
            if d.file == 'solution.go' then
              table.insert(diags, {
                lnum     = d.line - 1,
                col      = d.col,
                severity = vim.diagnostic.severity.ERROR,
                message  = d.msg,
                source   = 'go',
              })
            end
          end
        end

        local msg = first_msg
          or (candidate_lines[1] and candidate_lines[1]:sub(1, 160))
          or 'go test failed'
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
