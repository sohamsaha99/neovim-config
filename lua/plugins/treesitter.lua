return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      local langs = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "r",
        "rnoweb",
        "yaml",
        -- do not add "latex" in this list. VimTeX does not work with treesitter
      }
      require("nvim-treesitter").install(langs)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function()
          vim.treesitter.start()
        end,
      })
    end,
  }
}

