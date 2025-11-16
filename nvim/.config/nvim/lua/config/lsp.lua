local consts = require("consts")
vim.lsp.enable({
  "astro",
  "svelte",
  "lua_ls",
  "tailwindcss",
  "ts_ls",
})

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = {
    text = consts.signs,
    linehl = { [vim.diagnostic.severity.ERROR] = "ErrorMsg" },
    numhl = { [vim.diagnostic.severity.WARN] = "WarningMsg" },
  },
  severity_sort = true,
  float = vim.tbl_extend("force", consts.base_float_opts, {
    header = "", -- remove diagnostic label
    prefix = " ",
    format = function(diagnostic)
      local icon = consts.icons[diagnostic.severity] or ""
      return string.format("%s%s", icon, diagnostic.message)
    end,
  }),
})
