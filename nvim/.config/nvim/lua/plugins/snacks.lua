return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@module 'snacks'
  ---@type snacks.Config
  opts = {
    notifier = { enabled = true },
    dashboard = { enabled = true },
    explorer = {
      win = {
        show_query = false, -- Hides the built-in search/query bar
      },
      events = {
        on_open = function(_)
          -- Automatically close explorer buffer when file opens
          vim.defer_fn(function()
            -- safely close snacks explorer window only if still open
            if vim.bo.filetype == "snacks-explorer" then vim.cmd("close") end
          end, 10)
        end,
      },
      trash = true,
    },
    dashboard = {
      enabled = true,
      -- sections = {
      --   { section = "header" },
      --   { section = "keys", gap = 1, padding = 1 },
      --   { section = "startup" },
      --   {
      --     section = "terminal",
      --     cmd = "ascii-image-converter ~/madra.jpg -C -c",
      --     random = 80,
      --     pane = 2,
      --     indent = 15,
      --     height = 20,
      --   },
      -- },
    },
    terminal = {
      direction = "float", -- "float" | "horizontal" | "vertical"
      auto_insert = true, -- start in insert mode
      float_opts = {
        border = "rounded",
        width = 0.8,
        height = 0.4,
        row = 0.3,
        col = 0.1,
        winblend = 10, -- transparency
        winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      },
    },
    lazygit = {},
    picker = {
      sources = {
        explorer = {
          layout = {
            layout = { position = "right", width = 30 },
          },
        },
      },
      -- optional: customize popup look
      layout = {
        preset = "ivy",
        cycle = false,
      },
      layouts = {
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.5,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        },
      },
      border = "rounded",
      winhighlight = "NormalFloat:NormalFloat,FloatBorder:FloatBorder",
      matcher = {
        frecency = true,
      },
    },
  },
  keys = {
    { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "Lazygit Logs" },
    {
      "<S-h>",
      function()
        Snacks.picker.buffers({
          -- I always want my buffers picker to start in normal mode
          on_show = function() vim.cmd.stopinsert() end,
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
          -- In case you want to override the layout for this keymap
          -- layout = "ivy",
        })
      end,
      desc = "[P]Snacks picker buffers",
    },
    {
      "<leader>gbr",
      function() Snacks.picker.git_branches({ layout = "select" }) end,
      desc = "Pick and Switch Git Branches",
    },
    {
      "<leader>th",
      function() require("snacks").picker.colorschemes({ layout = "ivy" }) end,
      desc = "Pick Color Schemes",
    },
    { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
    { "<leader>fg", function() Snacks.picker("live_grep") end, { desc = "Live Grep" } },
    { "<leader>ff", function() Snacks.picker("files") end, desc = "Find files" },
    { "<C-\\>", function() Snacks.terminal.toggle() end, desc = "Toggle Snacks Terminal" },
  },
}
