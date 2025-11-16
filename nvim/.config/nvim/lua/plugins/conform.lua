return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      javascript = { "prettierd" },
      typescript = { "prettierd" },
      svelte = { "prettierd" },
      astro = { "prettierd" },
      css = { "prettierd" },
      html = { "prettierd" },
    },
    format_on_save = function(bufnr) return { timeout_ms = 500, lsp_fallback = true } end,
  },
  config = function(_, opts)
    require("conform").setup(opts)
    vim.keymap.set(
      "n",
      "<leader>f",
      function() require("conform").format({ async = true }) end,
      { desc = "Format buffer" }
    )
  end,
}
