-- User commands for rosetta-nvim.

if vim.g.loaded_rosetta_nvim then return end
vim.g.loaded_rosetta_nvim = 1

local function cmd(name, fn, opts)
  vim.api.nvim_create_user_command(name, fn, opts or {})
end

cmd('Rosetta',         function() require('rosetta').open_picker() end)
cmd('RosettaNext',     function() require('rosetta').next() end)
cmd('RosettaPrev',     function() require('rosetta').prev() end)
cmd('RosettaHint',     function() require('rosetta').hint() end)
cmd('RosettaCheck',    function() require('rosetta').check() end)
cmd('RosettaChat',     function() require('rosetta').chat() end)
cmd('RosettaReset',    function() require('rosetta').reset() end)
cmd('RosettaResetAll', function() require('rosetta').reset_all() end)
cmd('RosettaProgress', function() require('rosetta').show_progress() end)
cmd('RosettaLang',     function(a) require('rosetta').switch_lang(a.args ~= '' and a.args or nil) end, {
  nargs    = '?',
  complete = function()
    return require('rosetta.runners').langs()
  end,
})
