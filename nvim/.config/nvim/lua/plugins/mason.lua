local ensure_installed = {
  "typescript-language-server",
  "svelte-language-server",
  "astro-language-server",
  "marksman",
  "tailwindcss-language-server",
  "lua-language-server",
  "prettierd",
  "eslint_d",
}

return {
  "mason-org/mason.nvim",
  config = function()
    local mason = require("mason").setup({
      ui = {
        border = "rounded",
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })
    local reg = require("mason-registry")
    vim.defer_fn(function()
      for _, name in ipairs(ensure_installed) do
        local ok, pkg = pcall(reg.get_package, name)
        if ok and not pkg:is_installed() then pkg:install() end
      end
    end, 100)
  end,
}
