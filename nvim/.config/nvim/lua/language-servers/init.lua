local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require("language-servers.lsp-installer")
require("language-servers.handlers").setup()
