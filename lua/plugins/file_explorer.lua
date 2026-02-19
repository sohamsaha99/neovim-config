return {
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim"
    },
    keys = {
      -- Launch file browser
      { "<leader>fb", "<cmd>Telescope file_browser<CR>", desc = "Open file browser", silent = true }
    },
  },
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>e", "<cmd>NvimTreeToggle<CR>", desc = "Toggle file tree", silent = true },
    },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
}

