return {
  { "nvim-mini/mini.nvim", version = "*" },
  {
    "nvim-mini/mini.comment",
    version = false,
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    config = function()
      -- disable the autocommand from ts-context-commentstring
      require("ts_context_commentstring").setup({
        enable_autocmd = false,
      })

      require("mini.comment").setup({
        -- tsx, jsx, html , svelte comment support
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring({
              key = "commentstring",
            }) or vim.bo.commentstring
          end,
        },
      })
    end,
  },
  {
    "nvim-mini/mini.surround",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      -- Add custom surroundings to be used on top of builtin ones. For more
      -- information with examples, see `:h MiniSurround.config`.
      custom_surroundings = nil,

      -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
      highlight_duration = 300,

      -- Module mappings. Use `''` (empty string) to disable one.
      -- INFO:
      -- saiw surround with no whitespace
      -- saw surround with whitespace
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = "sf", -- Find surrounding (to the right)
        find_left = "sF", -- Find surrounding (to the left)
        highlight = "sh", -- Highlight surrounding
        replace = "sr", -- Replace surrounding
        update_n_lines = "sn", -- Update `n_lines`

        suffix_last = "l", -- Suffix to search with "prev" method
        suffix_next = "n", -- Suffix to search with "next" method
      },

      -- Number of lines within which surrounding is searched
      n_lines = 20,

      -- Whether to respect selection type:
      -- - Place surroundings on separate lines in linewise mode.
      -- - Place surroundings on each line in blockwise mode.
      respect_selection_type = false,

      -- How to search for surrounding (first inside current line, then inside
      -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
      -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
      -- see `:h MiniSurround.config`.
      search_method = "cover",

      -- Whether to disable showing non-error feedback
      silent = false,
    },
  },
  {
    "nvim-mini/mini.statusline",
    opts = {
      content = {
        -- Default layout minus filename, spans the entire width
        active = function()
          local S = require("mini.statusline")

          local mode, mode_hl = S.section_mode({ trunc_width = 120 })
          local git = S.section_git({ trunc_width = 75 })
          local diff = S.section_diff({ trunc_width = 75 })
          local diagnostics = S.section_diagnostics({ trunc_width = 75 })
          local lsp = S.section_lsp({ trunc_width = 75 })
          local fileinfo = S.section_fileinfo({ trunc_width = 120 })
          local location = S.section_location({ trunc_width = 75 })

          -- Use separators (%=) to evenly fill window width
          return S.combine_groups({
            { hl = mode_hl, strings = { mode } },
            { hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics, lsp } },
            "%=", -- expands between left and right sides — fills the middle gap
            { hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
            { hl = "MiniStatuslineLocation", strings = { location } },
          })
        end,
      },
    },
  },
  {
    "nvim-mini/mini.pairs",
    version = "*",
    event = "InsertEnter", -- load right before typing
    config = function() require("mini.pairs").setup() end,
  },
}
