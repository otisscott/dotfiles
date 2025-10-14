return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
    })

    -- Keybindings
    vim.keymap.set('n', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage Hunk' })
    vim.keymap.set('n', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', { desc = 'Reset Hunk' })
    vim.keymap.set('v', '<leader>hs', '<cmd>Gitsigns stage_hunk<CR>', { desc = 'Stage Hunk' })
    vim.keymap.set('v', '<leader>hr', '<cmd>Gitsigns reset_hunk<CR>', { desc = 'Reset Hunk' })
    vim.keymap.set('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>', { desc = 'Stage Buffer' })
    vim.keymap.set('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', { desc = 'Undo Stage Hunk' })
    vim.keymap.set('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>', { desc = 'Reset Buffer' })
    vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', { desc = 'Preview Hunk' })
    vim.keymap.set('n', '<leader>hb', '<cmd>Gitsigns blame_line<CR>', { desc = 'Blame Line' })
    vim.keymap.set('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>', { desc = 'Diff This' })
    vim.keymap.set('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>', { desc = 'Diff This ~' })
    vim.keymap.set('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>', { desc = 'Toggle Deleted' })
  end
}