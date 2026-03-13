--
-- lualine.lua
--
-- Custom status line
--

return {
  "nvim-lualine/lualine.nvim",
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  dependencies = { 'nvim-mini/mini.nvim' },
  event = "VeryLazy",
  config = function()
    -- Add separator between split panes, otherwise indistinguishable with transparent backgrounds
    vim.opt.fillchars = {
      stl = "─",
      stlnc = "─",
    }
    -- Import fidget spinner for CodeCompanion
    local cc_spinner = require("plugins.AI_coding.status")
    -- Custom Lualine component to show attached language server
    local clients_lsp = function()
      local clients = vim.lsp.get_clients()
      if next(clients) == nil then
        return ""
      end

      local c = {}
      for _, client in pairs(clients) do
        table.insert(c, client.name)
      end
      return " " .. table.concat(c, "|")
    end

    local custom_catppuccin = require("lualine.themes.catppuccin-nvim")

    -- Custom colours
    -- custom_catppuccin.normal.b.fg = "#cad3f5"
    -- custom_catppuccin.insert.b.fg = "#cad3f5"
    -- custom_catppuccin.visual.b.fg = "#cad3f5"
    -- custom_catppuccin.replace.b.fg = "#cad3f5"
    -- custom_catppuccin.command.b.fg = "#cad3f5"
    -- custom_catppuccin.inactive.a.bg = "#1e2030"
    --
    -- custom_catppuccin.normal.c.fg = "#6e738d"
    -- custom_catppuccin.normal.c.bg = "#1e2030"

    require("lualine").setup({
      options = {
        theme = custom_catppuccin,
        component_separators = "",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "Outline" },
      },
      sections = {
        lualine_a = {
          { cc_spinner, padding = { left = 0, right = 1 }, priority = 50 },
          {
            "mode",
            separator = { left = "", right = "" },
            -- icon = "",
            priority = 20
          },
        },
        lualine_b = {
          {
            "filetype",
            icon_only = true,
            padding = { left = 1, right = 0 },
          },
          { "filename", path = 1, priority = 100 }
        },
        lualine_c = {
          {
            "branch",
            icon = "",
          },
          {
            "diff",
            symbols = { added = " ", modified = " ", removed = " " },
            colored = false,
          },
          {
            function()
              if vim.wo.spell then
                return '󰓆' -- spellcheck on
              else
                return ''
              end
            end,
            color = { fg = '#ff9e64', gui = 'bold' }, -- optional highlight
          },
        },
        lualine_x = {
          {
            "diagnostics",
            symbols = { error = " ", warn = " ", info = " ", hint = " " },
            update_in_insert = true,
          },
        },
        lualine_y = { clients_lsp },
        lualine_z = {
          -- { "location" },
          {
            "progress",
            separator = { left = "", right = " " },
            -- icon = ""
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      extensions = { "toggleterm" },
    })
  end,
}
