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
      { "<leader>b", group = "Buffer" },
      { "<leader>bd", desc = "Delete Buffer" },
      { "<leader>e", desc = "Toggle File Explorer" },
      { "<leader>f", group = "Find" },
      { "<leader>fb", desc = "Buffers" },
      { "<leader>ff", desc = "Find Files" },
      { "<leader>fg", desc = "Git Files" },
      { "<leader>fh", desc = "Help Tags" },
      { "<leader>fl", desc = "Live Grep" },
      { "<leader>fw", desc = "Current Buffer Fuzzy Find" },
      { "<leader>o", desc = "Focus File Explorer" },
    })
  end
}