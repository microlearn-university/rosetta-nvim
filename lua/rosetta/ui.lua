-- Description / hints float + echo helpers for rosetta-nvim.

local M = {}

local state = { buf = nil, win = nil }

local function close_float()
  if state.win and vim.api.nvim_win_is_valid(state.win) then
    pcall(vim.api.nvim_win_close, state.win, true)
  end
  if state.buf and vim.api.nvim_buf_is_valid(state.buf) then
    pcall(vim.api.nvim_buf_delete, state.buf, { force = true })
  end
  state.buf, state.win = nil, nil
end

local function wrap(text, width)
  local out = {}
  for _, para in ipairs(vim.split(text, '\n', { plain = true })) do
    if para == '' then
      table.insert(out, '')
    else
      local line = ''
      for _, word in ipairs(vim.split(para, ' ', { plain = true })) do
        if line == '' then
          line = word
        elseif #line + 1 + #word > width then
          table.insert(out, line)
          line = word
        else
          line = line .. ' ' .. word
        end
      end
      if line ~= '' then table.insert(out, line) end
    end
  end
  return out
end

function M.show(ex, idx, total, lang, hints_shown)
  close_float()
  local width = math.min(72, vim.o.columns - 4)
  local lines = {}
  table.insert(lines, string.format(' %02d / %02d  ·  %s  ·  [%s]', idx, total, ex.title, lang))
  table.insert(lines, string.rep('─', width - 2))
  table.insert(lines, '')
  for _, l in ipairs(wrap(ex.description, width - 4)) do
    table.insert(lines, '  ' .. l)
  end
  if hints_shown > 0 then
    table.insert(lines, '')
    table.insert(lines, ' Hints:')
    for i = 1, math.min(hints_shown, #ex.hints) do
      table.insert(lines, '')
      for j, wl in ipairs(wrap(ex.hints[i], width - 8)) do
        local prefix = j == 1 and string.format('  %d. ', i) or '     '
        table.insert(lines, prefix .. wl)
      end
    end
  end
  table.insert(lines, '')

  local height = math.min(#lines + 1, vim.o.lines - 6)
  local row = 1
  local col = vim.o.columns - width - 2

  state.buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(state.buf, 0, -1, false, lines)
  vim.bo[state.buf].modifiable = false
  vim.bo[state.buf].buftype    = 'nofile'

  state.win = vim.api.nvim_open_win(state.buf, false, {
    relative  = 'editor',
    row       = row,
    col       = col,
    width     = width,
    height    = height,
    style     = 'minimal',
    border    = 'rounded',
    title     = ' rosetta ',
    title_pos = 'center',
    zindex    = 40,
  })
  vim.wo[state.win].wrap = false
  vim.wo[state.win].winhl = 'Normal:RosettaFloat,FloatBorder:RosettaBorder,FloatTitle:RosettaTitle'
end

function M.close()
  close_float()
end

function M.echo_checking()
  vim.api.nvim_echo({ { '[rosetta] checking… ', 'Comment' } }, false, {})
end

function M.echo_result(ok, message)
  local hl  = ok and 'RosettaSuccess' or 'RosettaError'
  local tag = ok and '✓ ' or '✗ '
  vim.api.nvim_echo({ { '[rosetta] ', 'Comment' }, { tag .. (message or ''), hl } }, false, {})
end

return M
