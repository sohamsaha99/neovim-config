return {
  {
    'renerocksai/telekasten.nvim',
    dependencies = {'nvim-telescope/telescope.nvim'},
    -- lazy = false,
    opts = {
      -- Put the name of your notes directory here
      home = vim.fn.expand("~/Writes/Notes"),
      -- if false, the telekasten filetype will not be set. Default true.
      auto_set_filetype = false,
      -- If enables, create new notes with <C-n>
      -- Disabling since <C-n> is often used to navigate Telescope and completion
      enable_create_new = false,
    },
    keys = {
      -- Launch panel
      { "<leader>z", "<cmd>Telekasten panel<CR>", desc = "Telekasten panel" },

      -- Most used functions
      { "<leader>zf", "<cmd>Telekasten find_notes<CR>", desc = "Find notes" },
      { "<leader>zg", "<cmd>Telekasten search_notes<CR>", desc = "Search notes" },
      { "<leader>zd", "<cmd>Telekasten goto_today<CR>", desc = "Goto today" },
      { "<leader>zz", "<cmd>Telekasten follow_link<CR>", desc = "Follow link" },
      { "<leader>zn", "<cmd>Telekasten new_note<CR>", desc = "New note" },
      -- { "<leader>zc", "<cmd>Telekasten show_calendar<CR>", desc = "Calendar" },
      { "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", desc = "Backlinks" },
      -- { "<leader>zI", "<cmd>Telekasten insert_img_link<CR>", desc = "Insert image link" },

      -- Insert mode mapping: [[ → insert link
      { "[[", "<cmd>Telekasten insert_link<CR>", mode = "i", desc = "Insert link" },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = {
      "markdown", "md", "rmd",
      "telekasten",
      "codecompanion"
    },
    dependencies = { 
      'nvim-treesitter/nvim-treesitter',
      'nvim-mini/mini.nvim'
    }, -- if you use the mini.nvim suite
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      -- completions = { blink = { enabled = true } }
    },
  }
}

