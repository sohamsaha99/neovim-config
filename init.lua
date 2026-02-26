-- Disable netrw (must be set before plugins load)
-- Recommended by nvim-tree plugin
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true
-- See few lines of context in top pr bottom
vim.opt.scrolloff = 5

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Filetype & syntax
vim.cmd("syntax on") -- usually enabled by default in Neovim
vim.cmd("filetype plugin indent on") -- also default in Neovim >=0.7

-- Tabs & indentation
vim.opt.tabstop = 2          -- number of spaces a <Tab> counts for
vim.opt.shiftwidth = 2       -- number of spaces to use for each step of indent
vim.opt.expandtab = true     -- convert tabs to spaces

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
-- vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
-- vim.o.signcolumn = 'yes'

-- Spell check for certain filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "latex", "tex", "md", "markdown" },
  callback = function()
    vim.opt_local.spell = true
  end,
})

require('config.lazy')
-- require('config.netrw')

vim.cmd.colorscheme "catppuccin"
-- catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha

