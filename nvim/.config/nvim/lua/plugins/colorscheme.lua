return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require("rose-pine").setup({
        styles = {
          bold = true,
          italic = true,
          transparency = true,
        },
      })
    end,
  },
  {
    "rebelot/kanagawa.nvim",
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        transparent = true,
        theme = { name = "dragon" },

        overrides = function(colors)
          local theme = colors.theme
          local p = colors.palette
          return {
            NormalFloat = { bg = "none" },
            FloatBorder = { bg = "none" },
            FloatTitle = { bg = "none" },

            BufferLineFill = { bg = "NONE" },
            BufferLineBackground = { bg = "NONE", fg = p.fujiGray },
            BufferLineBufferVisible = { bg = "NONE", fg = p.fujiGray },
            BufferLineBufferSelected = { bg = "NONE", fg = p.dragonWhite, bold = true },
            BufferLineTabClose = { bg = "NONE" },
            BufferLineSeparator = { bg = "NONE", fg = p.sumiInk4 },
            BufferLineSeparatorVisible = { bg = "NONE", fg = p.sumiInk4 },
            BufferLineSeparatorSelected = { bg = "NONE", fg = p.sumiInk4 },
            BufferLineIndicatorSelected = { bg = "NONE", fg = p.boatYellow2 },

            GitSignsAdd = { bg = "none", fg = p.springGreen },
            GitSignsChange = { bg = "none", fg = p.boatYellow2 },
            GitSignsDelete = { bg = "none", fg = p.peachRed },
            TabLineFill = { bg = "NONE" },

            -- (optional) transparent SignColumn background

            NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },

            LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
            MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },

            Pmenu = { fg = theme.ui.shade0, bg = "none" }, -- add `blend = vim.o.pumblend` to enable transparency,,
            PmenuSel = { fg = "NONE", bg = theme.ui.bg_p2 },
            PmenuSbar = { bg = theme.ui.bg_m1 },
            PmenuThumb = { bg = "#C0A36E" },
            BlinkCmpMenuBorder = { fg = "", bg = "" },
            SignColumn = { bg = "none" },
            LineNr = { bg = "none", fg = p.fujiGray },

            CursorLine = { bg = "NONE" },
            CursorLineNr = { fg = p.dragonWhite, bg = "NONE", bold = true },

            DiagnosticSignError = { fg = p.peachRed, bg = "none" },
            DiagnosticSignWarn = { fg = p.boatYellow2, bg = "none" },
            DiagnosticSignInfo = { fg = p.waveAqua2, bg = "none" },
            DiagnosticSignHint = { fg = p.springViolet1, bg = "none" },
            DiagnosticSignOk = { fg = p.springGreen, bg = "none" },

            DiagnosticFloatingError = { fg = p.peachRed, bg = "none" },
            DiagnosticFloatingWarn = { fg = p.boatYellow2, bg = "none" },
            DiagnosticFloatingInfo = { fg = p.waveAqua2, bg = "none" },
            DiagnosticFloatingHint = { fg = p.springViolet1, bg = "none" },
          }
        end,
      })
    end,
  },
}
