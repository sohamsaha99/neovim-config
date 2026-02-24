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
    lazy = true,
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    keys = {
      { "<leader>ca", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "(C)odeCompanion (A)ctions" },
      { "<leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", mode = { "n", "v" }, desc = "(C)odeCompanion (C)hat" },
      { "<leader>cs", "<cmd>CodeCompanionChat Add<cr>", mode = "v", desc = "(C)odeCompanion (S)end to chat" },
    },
    config = function()
      load_openai_key()

      require("codecompanion").setup({
        prompt_library = {
          markdown = {
            dirs = {
              vim.fn.getcwd() .. "/.prompts/skills/", -- Can be relative
            },
          },
        },
        adapters = {
          http = {
            opts = {
              show_presets = false,
            },
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
            opts = {
              show_presets = false,
            },
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
            opencode = function()
              return require("codecompanion.adapters").extend("opencode", {})
            end,
          },
        },
        interactions = {
          chat = {
            adapter = "openai", -- "codex"
          },
          inline = {
            adapter = "openai", -- "openai"
          },
          cmd = {
            adapter = "openai", -- "openai"
          },
        },
      })

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
        picker = "snacks",
        tools = {
          gemini = { cmd = { "gemini" } },
          codex = { cmd = { "codex" } },
          opencode = {
            cmd = { "opencode" },
            -- HACK: https://github.com/sst/opencode/issues/445
            env = { OPENCODE_THEME = "system" },
          },
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
        "<leader>ao",
        function()
          require("sidekick.cli").show({ name = "opencode" })
        end,
        desc = "(A)I (O)pencode CLI",
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
}
