require("drk")

-- General
require("drk.options")
require("drk.plugins")
require("drk.keybindings")

-- LSP and Autocomplete
require("language-servers")

local user_config = CONFIG_PATH .. "/lua/drk/user-config/init.lua"

if not Drk.utils.file.exists(user_config) then
	Drk.utils.file.create(user_config)
end

-- User config that overrides the above
vim.cmd("luafile " .. user_config)

if Drk.settings.colorscheme ~= "custom" then
	Drk.utils.plugins.require("colorscheme." .. Drk.settings.colorscheme)
end


