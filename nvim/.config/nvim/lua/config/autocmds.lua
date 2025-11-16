local autocmd = vim.api.nvim_create_autocmd

autocmd("CursorHold", {

  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
    })
  end,
})

autocmd("VimLeavePre", {
  callback = function() vim.fn.jobstart("killall prettierd eslint_d", { detach = true }) end,
})
