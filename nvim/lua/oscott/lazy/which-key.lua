return {
  "folke/which-key.nvim",
  dependencies = { "echasnovski/mini.icons" },
  config = function()
    require("which-key").setup({
      -- your configuration comes here
      -- or leave it empty to use the default settings
    })

    -- Register leader key mappings using new spec format
    local wk = require("which-key")
    wk.add({
      -- Buffer operations
      { "<leader>b", group = "Buffer" },
      { "<leader>bd", desc = "Delete Buffer" },
      
      -- File explorer
      { "<leader>e", desc = "Toggle File Explorer" },
      { "<leader>o", desc = "Focus File Explorer" },
      
      -- Find/Telescope
      { "<leader>f", group = "Find" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Git Files" },
      { "<leader>fh", desc = "Help Tags" },
      { "<leader>fl", desc = "Live Grep" },
      { "<leader>fw", desc = "Current Buffer Fuzzy Find" },
      
      -- Git operations
      { "<leader>h", group = "Git Hunk" },
      { "<leader>hb", desc = "Blame Line" },
      { "<leader>hd", desc = "Diff This" },
      { "<leader>hD", desc = "Diff This ~" },
      { "<leader>hp", desc = "Preview Hunk" },
      { "<leader>hR", desc = "Reset Buffer" },
      { "<leader>hr", desc = "Reset Hunk" },
      { "<leader>hS", desc = "Stage Buffer" },
      { "<leader>hs", desc = "Stage Hunk" },
      { "<leader>hu", desc = "Undo Stage Hunk" },
      { "<leader>td", desc = "Toggle Deleted" },
      
      -- Todo comments
      { "<leader>t", group = "Todo" },
      { "<leader>tl", desc = "Todo Location List" },
      { "<leader>tq", desc = "Todo Quick Fix" },
      { "<leader>tt", desc = "Todo Telescope" },
      
      -- Trouble/diagnostics
      { "<leader>x", group = "Trouble" },
      { "<leader>xd", desc = "Document Diagnostics" },
      { "<leader>xl", desc = "Location List" },
      { "<leader>xq", desc = "Quickfix List" },
      { "<leader>xw", desc = "Workspace Diagnostics" },
      { "<leader>xx", desc = "Toggle Trouble" },
      { "<leader>gr", desc = "LSP References" },
    })
  end
}