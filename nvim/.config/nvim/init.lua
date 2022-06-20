require("user")

require("user.options")
require("user.plugins")
require("user.bindings")

-- LSP and Autocomplete
require("language-servers")

if User.settings.colorscheme ~= "custom" then
	User.utils.plugin.require("colorscheme." .. User.settings.colorscheme)
end
