local M = {}

M.icons = {
  [vim.diagnostic.severity.ERROR] = " ",
  [vim.diagnostic.severity.WARN] = " ",
  [vim.diagnostic.severity.INFO] = " ",
  [vim.diagnostic.severity.HINT] = " ",
}

M.signs = {}
for severity, icon in pairs(M.icons) do
  M.signs[severity] = vim.trim(icon)
end

M.base_float_opts = {
  border = "rounded",
  focusable = false,
  anchor = "SW",
  relative = "cursor",
  max_height = 6,
  max_width = 80,
}

return M
