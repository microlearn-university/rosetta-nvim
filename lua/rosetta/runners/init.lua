-- Runner dispatch. Each language runner exposes:
--   M.edit_file(work_dir) -> absolute path the student should edit
--   M.check(work_dir, callback)  -- callback(ok, diagnostics, message)

local M = {}

local BY_LANG = {
  python     = 'rosetta.runners.python',
  rust       = 'rosetta.runners.rust',
  go         = 'rosetta.runners.go',
  typescript = 'rosetta.runners.typescript',
}

function M.for_lang(lang)
  local mod = BY_LANG[lang]
  if not mod then
    error('[rosetta] unknown language: ' .. tostring(lang))
  end
  return require(mod)
end

function M.langs()
  local out = {}
  for k, _ in pairs(BY_LANG) do table.insert(out, k) end
  table.sort(out)
  return out
end

return M
