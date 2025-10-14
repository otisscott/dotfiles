return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("trouble").setup({
      auto_close = true,
      auto_preview = true,
      auto_jump = {},
      focus = false,
      restore = true,
      follow = true,
      indent_guides = true,
      max_items = 200,
      multiline = true,
      pinned = false,
      warn_no_results = true,
      open_no_results = false,
      win = { size = { height = 0.6 } },
      preview = {
        type = "split",
        relative = "win",
        position = "right",
        size = 0.3,
      },
    })

    -- Keybindings
    vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<CR>', { desc = 'Toggle Trouble' })
    vim.keymap.set('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics<CR>', { desc = 'Workspace Diagnostics' })
    vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<CR>', { desc = 'Document Diagnostics' })
    vim.keymap.set('n', '<leader>xl', '<cmd>TroubleToggle loclist<CR>', { desc = 'Location List' })
    vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<CR>', { desc = 'Quickfix List' })
    vim.keymap.set('n', '<leader>gr', '<cmd>TroubleToggle lsp_references<CR>', { desc = 'LSP References' })
  end
}