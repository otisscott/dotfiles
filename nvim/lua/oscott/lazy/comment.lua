return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      -- add any options here
    })

    -- Keybindings
    vim.keymap.set('n', '<leader>/', '<cmd>lua require("Comment.api").toggle.linewise.current()<CR>', { desc = 'Toggle Comment' })
    vim.keymap.set('v', '<leader>/', '<esc><cmd>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', { desc = 'Toggle Comment' })
  end
}