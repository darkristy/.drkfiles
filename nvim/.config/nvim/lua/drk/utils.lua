local M = {}

local require_plugin = function(p)
	if Drk.plugins[p] ~= nil and not Drk.plugins[p].enabled then
		return nil
	end

	local ok, plugin = pcall(require, p)

	if ok then
		return plugin
	else
		return nil
	end
end

local packadd_plugin = function(p, return_plugin)
	vim.cmd("packadd! " .. p)

	if return_plugin == true then
		return require_plugin(p)
	end
end


M.plugin = {
	require = require_plugin,
	packadd = packadd_plugin,
}

return M
