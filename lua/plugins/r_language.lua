return {
  {
    "R-nvim/R.nvim",
    -- "jalvesaq/Vim-R",
    -- ft = { "r", "rmd" },
    -- build = ":call RBuild()",
    lazy = false,
    opts = {
      compl_data = {
        -- max_depth = 3, -- These are defaults
        -- max_size = 1000000, -- These are defaults
        max_time = 200, -- Default is 100ms
      },
      -- hook = {
      --   after_config = function()
      --     -- Optional: automatically start R when opening an .R file
      --     vim.g.R_auto_start = 1
      --   end,
      -- },
    },
  },

  -- LSP: R languageserver (install in R: install.packages("languageserver"))
  -- {
  --   "neovim/nvim-lspconfig",
  --   -- ft = { "r", "rmd", "quarto" },
  --   dependencies = { "saghen/blink.cmp" },
  --   config = function()
  --     -- print(os.date("%H:%M:%S"))
  --     local capabilities = require("blink.cmp").get_lsp_capabilities()
  --     vim.lsp.config("r_language_server", {
  --       capabilities = capabilities,
  --     })
  --     vim.lsp.enable("r_language_server")
  --   end,
  -- },
}

