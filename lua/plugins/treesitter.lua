return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    -- event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- Keep this list small and focused; add more languages as needed.
      ensure_installed = {
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "r",
        "yaml",
        "rnoweb",
      },
      -- VimTeX is strongly recommended for LaTeX highlighting; avoid TS LaTeX.
      ignore_install = { "latex" },
    },
  },
}

