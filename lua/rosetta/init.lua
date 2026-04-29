-- rosetta-nvim: multi-language algorithm exercises inside Neovim.
-- Modeled after ferris.nvim, with a language dimension: each exercise has
-- per-language stubs and a language-specific test runner.

local M = {}

local registry = require('rosetta.registry')
local runners  = require('rosetta.runners')
local progress = require('rosetta.progress')
local ui       = require('rosetta.ui')
local chat     = require('rosetta.chat')

local state = {
  idx         = 1,
  lang        = nil,
  hints_shown = 0,
  checking    = false,
  augroup     = nil,
  buf         = nil,
  plugin_dir  = nil,
  work_dir    = nil,
}

-- ── Helpers ─────────────────────────────────────────────────────────────────

local function plugin_dir()
  if state.plugin_dir then return state.plugin_dir end
  local info = debug.getinfo(1, 'S')
  -- source is "@/path/to/lua/rosetta/init.lua" → up three levels
  state.plugin_dir = vim.fn.fnamemodify(info.source:sub(2), ':h:h:h')
  return state.plugin_dir
end

local function stub_dir(ex, lang)
  return plugin_dir() .. '/exercises/' .. ex.id .. '/stubs/' .. lang
end

local function setup_highlights()
  local groups = {
    RosettaFloat   = { bg = '#1e1e2e', fg = '#cdd6f4' },
    RosettaBorder  = { fg = '#b4befe' },  -- lavender
    RosettaTitle   = { fg = '#b4befe', bold = true },
    RosettaSuccess = { fg = '#a6e3a1', bold = true },
    RosettaError   = { fg = '#f38ba8', bold = true },
  }
  for name, opts in pairs(groups) do
    if vim.fn.hlexists(name) == 0 then
      vim.api.nvim_set_hl(0, name, opts)
    end
  end
end

local function ns()
  return vim.api.nvim_create_namespace('rosetta')
end

local function supported_langs(ex)
  return ex.languages or runners.langs()
end

local function pick_lang(ex, cb)
  local langs = supported_langs(ex)
  if #langs == 1 then cb(langs[1]); return end
  local prog = progress.load()
  local default = prog.last_lang[ex.id] or prog.current_lang
  -- Re-order so the default is first in the picker.
  if default and vim.tbl_contains(langs, default) then
    local reordered = { default }
    for _, l in ipairs(langs) do
      if l ~= default then table.insert(reordered, l) end
    end
    langs = reordered
  end
  vim.ui.select(langs, { prompt = 'Language for ' .. ex.title .. ':' }, function(choice)
    if choice then cb(choice) end
  end)
end

-- ── Public API ──────────────────────────────────────────────────────────────

function M.setup(opts)
  opts = opts or {}
  setup_highlights()
  if opts.chat then chat.setup(opts.chat) end
  local prog = progress.load()
  state.idx = math.max(1, math.min(prog.current_idx or 1, #registry))
end

function M.open(idx, lang)
  setup_highlights()
  idx = math.max(1, math.min(idx or state.idx, #registry))
  local ex = registry[idx]

  local function proceed(chosen_lang)
    if not vim.tbl_contains(supported_langs(ex), chosen_lang) then
      vim.notify(
        string.format('[rosetta] %s does not have a %s stub', ex.title, chosen_lang),
        vim.log.levels.WARN
      )
      return
    end

    state.idx         = idx
    state.lang        = chosen_lang
    state.hints_shown = 0

    -- Seed working copy for (ex, lang), open the editable file.
    local work = progress.ensure_work_dir(ex.id, chosen_lang, stub_dir(ex, chosen_lang))
    state.work_dir = work
    local runner = runners.for_lang(chosen_lang)
    local edit   = runner.edit_file(work)

    -- Persist selection.
    local prog = progress.load()
    prog.current_idx  = idx
    prog.current_lang = chosen_lang
    prog.last_lang[ex.id] = chosen_lang
    progress.save(prog)

    vim.cmd('edit ' .. vim.fn.fnameescape(edit))
    state.buf = vim.api.nvim_get_current_buf()

    -- Auto-check on save.
    if state.augroup then
      pcall(vim.api.nvim_del_augroup_by_id, state.augroup)
    end
    state.augroup = vim.api.nvim_create_augroup('RosettaAutoCheck', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
      group    = state.augroup,
      buffer   = state.buf,
      callback = function() M.check() end,
    })

    ui.show(ex, idx, #registry, chosen_lang, state.hints_shown)
  end

  if lang then
    proceed(lang)
  else
    pick_lang(ex, proceed)
  end
end

function M.check()
  if state.checking then return end
  local ex = registry[state.idx]
  if not (ex and state.lang and state.work_dir) then return end

  state.checking = true
  vim.diagnostic.reset(ns(), state.buf)
  ui.echo_checking()

  local runner = runners.for_lang(state.lang)
  runner.check(state.work_dir, function(ok, diags, message)
    state.checking = false
    vim.diagnostic.set(ns(), state.buf or 0, diags or {}, {})
    if ok then
      progress.mark_complete(ex.id, state.lang)
    end
    ui.echo_result(ok, message)
  end)
end

function M.hint()
  local ex = registry[state.idx]
  if not ex then return end
  if state.hints_shown >= #ex.hints then
    vim.notify('[rosetta] no more hints for this exercise', vim.log.levels.INFO)
    return
  end
  state.hints_shown = state.hints_shown + 1
  ui.show(ex, state.idx, #registry, state.lang, state.hints_shown)
end

function M.next()
  if state.idx >= #registry then
    vim.notify('[rosetta] 🎉 you have reached the end of the curriculum', vim.log.levels.INFO)
    return
  end
  M.open(state.idx + 1, state.lang)
end

function M.prev()
  if state.idx <= 1 then return end
  M.open(state.idx - 1, state.lang)
end

function M.reset()
  local ex = registry[state.idx]
  if not (ex and state.lang) then return end
  progress.reset(ex.id, state.lang, stub_dir(ex, state.lang))
  M.open(state.idx, state.lang)
  vim.notify('[rosetta] exercise reset', vim.log.levels.INFO)
end

function M.switch_lang(lang)
  local ex = registry[state.idx]
  if not ex then return end
  if lang then
    M.open(state.idx, lang)
  else
    pick_lang(ex, function(chosen) M.open(state.idx, chosen) end)
  end
end

function M.chat()
  local ex = registry[state.idx]
  if not (ex and state.lang and state.work_dir) then
    vim.notify('[rosetta] open an exercise first', vim.log.levels.WARN)
    return
  end
  local runner = runners.for_lang(state.lang)
  chat.open(ex, state.lang, runner.edit_file(state.work_dir))
end

function M.reset_all()
  progress.reset_all()
  state.idx = 1
  state.lang = nil
  vim.notify('[rosetta] all progress reset', vim.log.levels.INFO)
end

function M.open_picker()
  setup_highlights()
  local prog  = progress.load()
  local items = {}
  for i, ex in ipairs(registry) do
    local done_any = false
    for _, l in ipairs(supported_langs(ex)) do
      if vim.tbl_contains(prog.completed, ex.id .. '::' .. l) then
        done_any = true; break
      end
    end
    table.insert(items, string.format('%s %02d  %s', done_any and '✓' or '○', i, ex.title))
  end
  vim.ui.select(items, { prompt = 'rosetta — pick an algorithm' }, function(_, idx)
    if idx then M.open(idx) end
  end)
end

function M.show_progress()
  local prog = progress.load()
  local lines = { '', '  rosetta — progress', string.rep('─', 42), '' }
  for i, ex in ipairs(registry) do
    local marks = {}
    for _, l in ipairs(supported_langs(ex)) do
      local done = vim.tbl_contains(prog.completed, ex.id .. '::' .. l)
      table.insert(marks, string.format('%s %s', done and '✓' or '○', l))
    end
    table.insert(lines, string.format('  %02d  %-24s  %s', i, ex.title, table.concat(marks, '  ')))
  end
  table.insert(lines, '')
  local out = {}
  for _, l in ipairs(lines) do table.insert(out, { l .. '\n', 'Normal' }) end
  vim.api.nvim_echo(out, true, {})
end

-- Initialise state from saved progress on first require.
do
  local prog = progress.load()
  state.idx = math.max(1, math.min(prog.current_idx or 1, #registry))
end

return M
