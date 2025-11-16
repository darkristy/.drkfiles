local u = require("utils")
-- lua/plugins/neotree.lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, for file icons
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle Neo-tree" },
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      default_component_configs = {
        indent = { padding = 1 },
        icon = { folder_closed = "", folder_open = "", default = "" },
        name = { trailing_slash = true, use_git_status_colors = true },
        git_status = {
          symbols = {
            added = "",
            modified = "",
            deleted = "",
            renamed = "",
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },

      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = true,
          hide_by_name = { "node_modules", ".git" },
        },
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        hijack_netrw_behavior = "open_default",
        use_libuv_file_watcher = true, -- instant refresh without manual reload
        window = {
          position = "right",
          width = 32,
          mappings = {
            ["<space>"] = "none",
            ["l"] = "open",
            ["h"] = "close_node",
            ["<CR>"] = "open",
            ["a"] = "add",
            ["r"] = "rename",
            ["d"] = "trash_delete",
            ["."] = "toggle_hidden",
            ["q"] = "close_window",
          },
        },
        commands = {
          trash_delete = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            local confirm = vim.fn.confirm("Move to Trash?\n" .. path, "&Yes\n&Cancel", 1)
            if confirm ~= 1 then return end

            u.delete(path, function(success)
              if not success then return end
              require("neo-tree.sources.manager").refresh(state.name)
            end)
          end,
        },
      },

      event_handlers = {
        {
          event = "file_opened",
          handler = function(file_path) require("neo-tree").close_all() end,
        },
      },
    })
  end,
}
