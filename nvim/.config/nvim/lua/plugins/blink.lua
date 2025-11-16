return {
  "saghen/blink.cmp",
  version = "1.*",
  build = "cargo build --release",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  opts = {
    enabled = function()
      local exclude_filetypes = {
        "grug-far",
      }
      return not vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
    end,
    keymap = {
      ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      ["<CR>"] = { "accept", "fallback" },

      ["<Tab>"] = { "snippet_forward", "select_next", "fallback" },
      ["<S-Tab>"] = { "snippet_backward", "select_prev", "fallback" },

      ["<Up>"] = { "select_prev", "fallback" },
      ["<Down>"] = { "select_next", "fallback" },

      ["<C-k>"] = { "show_signature", "hide_signature", "fallback" },
    },
    appearance = {
      nerd_font_variant = "normal",
    },
    sources = {
      default = { "lsp", "path", "buffer", "snippets" },
    },
    completion = {
      keyword = {
        range = "full",
      },
      trigger = {
        show_on_insert = false,
        show_in_snippet = false,
        show_on_backspace = true,
        show_on_backspace_in_keyword = true,
      },
      list = {
        selection = {
          preselect = false,
          auto_insert = true,
        },
      },
      ghost_text = {
        enabled = true,
      },
      accept = {
        auto_brackets = {
          enabled = false,
        },
      },

      menu = {
        enabled = true,
        border = "rounded",
        -- draw = {
        -- 	treesitter = { "lsp" },
        -- 	columns = {
        -- 		{ "kind_icon" },
        -- 		{ "label", "label_description", gap = 1 },
        -- 		{ "source_name" },
        -- 	},
        -- },
      },
      documentation = {
        auto_show = true,
        treesitter_highlighting = true,
        window = {
          border = { "🭽", "▔", "🭾", "▕", "🭿", "▁", "🭼", "▏" },
          -- winblend = 6,
        },
      },
    },
  },
}
