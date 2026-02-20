local function load_openai_key()
  local keyfile = vim.fn.expand("~/.passwords/openai.key")
  if vim.fn.filereadable(keyfile) == 1 then
    local lines = vim.fn.readfile(keyfile)
    if #lines > 0 and lines[1] ~= "" then
      vim.env.OPENAI_API_KEY = lines[1]
      vim.env.AVANTE_OPENAI_API_KEY = lines[1]
    end
  end
end

return {
  {
    "olimorris/codecompanion.nvim",
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      load_openai_key()

      require("codecompanion").setup({
        adapters = {
          http = {
            -- Set up OpenAI API
            openai = function()
              return require("codecompanion.adapters").extend("openai", {
                env = {
                  api_key = vim.env.OPENAI_API_KEY,
                },
                schema = {
                  model = {
                    default = "gpt-5",
                  },
                },
              })
            end,
          },
          -- Set up Codex CLI Integration with codex-acp (executable in ~/.local/bin)
          acp = {
            codex = function()
              return require("codecompanion.adapters").extend("codex", {
                defaults = {
                  auth_method = "chatgpt", -- "openai-api-key"|"codex-api-key"|"chatgpt"
                },
              })
            end,
            gemini_cli = function()
              return require("codecompanion.adapters").extend("gemini_cli", {
                defaults = {
                  auth_method = "oauth-personal", -- "oauth-personal"|"gemini-api-key"|"vertex-ai"
                },
              })
            end,
          },
        },
        interactions = {
          chat = {
            adapter = "codex", -- "openai"
          },
          inline = {
            adapter = "codex", -- "openai"
          },
          cmd = {
            adapter = "codex", -- "openai"
          },
        },
      })

      -- set up keymaps
      vim.keymap.set({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "(C)odeCompanion (A)ctions" })
      vim.keymap.set({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "(C)odeCompanion (C)hat" })
      vim.keymap.set("v", "<leader>cs", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true, desc = "(C)odeCompanion (S)end to chat" })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
  {
    "folke/sidekick.nvim",
    opts = {
      nes = {
        enabled = false,
      },
      cli = {
        picker = "telescope",
        tools = {
          gemini = { cmd = { "gemini" } },
          codex = { cmd = { "codex" } },
        },
      },
    },
    keys = {
      {
        "<leader>ac",
        function()
          require("sidekick.cli").show({ name = "codex" })
        end,
        desc = "(A)I (C)odex CLI",
      },
      {
        "<leader>ag",
        function()
          require("sidekick.cli").show({ name = "gemini" })
        end,
        desc = "(A)I (G)emini CLI",
      },
      {
        "<leader>at",
        function()
          require("sidekick.cli").toggle()
        end,
        desc = "(A)I Window (T)oggle",
      },
      {
        "<leader>aq",
        function()
          require("sidekick.cli").close()
        end,
        desc = "(A)I Window (Q)uit",
      },
    },
  },

  -- {
  --   "yetone/avante.nvim",
  --   event = "VeryLazy",
  --   build = "make",
  --   version = false,
  --   ---@module 'avante'
  --   ---@type avante.Config
  --   opts = {
  --     instructions_file = "avante.md",
  --     provider = "openai",
  --     auto_suggestions_provider = "openai",
  --     selector = {
  --       provider = "telescope",
  --     },
  --     providers = {
  --       openai = {
  --         model = "gpt-5",
  --       },
  --     },
  --   },
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "MunifTanjim/nui.nvim",
  --     "nvim-telescope/telescope.nvim",
  --     "saghen/blink.compat",
  --     "nvim-tree/nvim-web-devicons",
  --     {
  --       "saghen/blink.cmp",
  --       opts = function(_, opts)
  --         opts.sources = opts.sources or {}
  --
  --         -- 1) Add to sources.default
  --         opts.sources.default = opts.sources.default or {}
  --         local default = opts.sources.default
  --
  --         local function add_unique(list, item)
  --           for _, v in ipairs(list) do
  --             if v == item then return end
  --           end
  --           table.insert(list, item)
  --         end
  --
  --         add_unique(default, "avante_commands")
  --         add_unique(default, "avante_mentions")
  --         add_unique(default, "avante_shortcuts")
  --         add_unique(default, "avante_files")
  --
  --         -- 2) Add providers
  --         opts.sources.providers = opts.sources.providers or {}
  --
  --         opts.sources.providers.avante_commands = {
  --           name = "avante_commands",
  --           module = "blink.compat.source",
  --           score_offset = 90, -- show at a higher priority than lsp
  --           opts = {},
  --         }
  --
  --         opts.sources.providers.avante_files = {
  --           name = "avante_files",
  --           module = "blink.compat.source",
  --           score_offset = 100, -- show at a higher priority than lsp
  --           opts = {},
  --         }
  --
  --         opts.sources.providers.avante_mentions = {
  --           name = "avante_mentions",
  --           module = "blink.compat.source",
  --           score_offset = 1000, -- show at a higher priority than lsp
  --           opts = {},
  --         }
  --
  --         opts.sources.providers.avante_shortcuts = {
  --           name = "avante_shortcuts",
  --           module = "blink.compat.source",
  --           score_offset = 1000, -- show at a higher priority than lsp
  --           opts = {},
  --         }
  --       end,
  --     },
  --   },
  --   config = function(_, opts)
  --     load_openai_key()
  --     require("avante").setup(opts)
  --
  --     vim.keymap.set("n", "<leader>at", "<cmd>AvanteToggle<cr>", { noremap = true, silent = true, desc = "(A)I Avan(t)e Toggle" })
  --     vim.keymap.set({ "n", "v" }, "<leader>aq", "<cmd>AvanteAsk<cr>", { noremap = true, silent = true, desc = "(A)I As(k)" })
  --   end,
  -- },
}
