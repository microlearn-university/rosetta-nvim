-- Persistence: progress.json + working-copy directories per (algo, lang).

local M = {}

local function data_dir()
  return vim.fn.stdpath('data') .. '/rosetta-nvim'
end

local function progress_file()
  return data_dir() .. '/progress.json'
end

-- Base dir for editable working copies: one directory per (algo, lang).
local function work_dir(algo_id, lang)
  return data_dir() .. '/work/' .. algo_id .. '/' .. lang
end

local function progress_key(algo_id, lang)
  return algo_id .. '::' .. lang
end

-- ── Progress data ────────────────────────────────────────────────────────────

function M.load()
  local f = progress_file()
  if vim.fn.filereadable(f) == 0 then
    return { completed = {}, current_idx = 1, current_lang = nil, last_lang = {} }
  end
  local lines = vim.fn.readfile(f)
  local ok, data = pcall(vim.json.decode, table.concat(lines, '\n'))
  if not (ok and data) then
    return { completed = {}, current_idx = 1, current_lang = nil, last_lang = {} }
  end
  data.completed    = data.completed    or {}
  data.last_lang    = data.last_lang    or {}
  data.current_idx  = data.current_idx  or 1
  return data
end

function M.save(data)
  vim.fn.mkdir(data_dir(), 'p')
  vim.fn.writefile({ vim.json.encode(data) }, progress_file())
end

function M.mark_complete(algo_id, lang)
  local data = M.load()
  local key = progress_key(algo_id, lang)
  if not vim.tbl_contains(data.completed, key) then
    table.insert(data.completed, key)
  end
  M.save(data)
end

function M.is_complete(algo_id, lang)
  return vim.tbl_contains(M.load().completed, progress_key(algo_id, lang))
end

function M.remember_lang(algo_id, lang)
  local data = M.load()
  data.last_lang[algo_id] = lang
  data.current_lang = lang
  M.save(data)
end

-- ── Working copies ───────────────────────────────────────────────────────────

-- Seed the per-user working directory from the shipped stub dir.
-- Only copies files that don't already exist so user edits survive.
local function seed_work_dir(stub_dir, dest_dir)
  vim.fn.mkdir(dest_dir, 'p')
  local entries = vim.fn.readdir(stub_dir)
  for _, name in ipairs(entries) do
    local src  = stub_dir .. '/' .. name
    local dest = dest_dir .. '/' .. name
    if vim.fn.isdirectory(src) == 0 and vim.fn.filereadable(dest) == 0 then
      vim.fn.system({ 'cp', src, dest })
    end
  end
end

-- Ensure the working directory for (algo, lang) exists and is seeded.
-- `stub_dir` is the shipped source dir (exercises/<id>/stubs/<lang>).
function M.ensure_work_dir(algo_id, lang, stub_dir)
  local w = work_dir(algo_id, lang)
  seed_work_dir(stub_dir, w)
  return w
end

function M.work_dir(algo_id, lang)
  return work_dir(algo_id, lang)
end

function M.reset(algo_id, lang, stub_dir)
  local w = work_dir(algo_id, lang)
  vim.fn.delete(w, 'rf')
  return M.ensure_work_dir(algo_id, lang, stub_dir)
end

function M.reset_all()
  vim.fn.delete(data_dir() .. '/work', 'rf')
  M.save({ completed = {}, current_idx = 1, current_lang = nil, last_lang = {} })
end

return M
