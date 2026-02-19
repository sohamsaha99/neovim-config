return {
  "olimorris/codecompanion.nvim",
  opts = {},
  dependencies = {
    "nvim-lua/plenary.nvim",
    -- "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    -- Read OpenAI key from an external file and export to the env
    local keyfile = vim.fn.expand("~/openai.key")
    if vim.fn.filereadable(keyfile) == 1 then
      local lines = vim.fn.readfile(keyfile)
      if #lines > 0 and lines[1] ~= "" then
        vim.env.OPENAI_API_KEY = lines[1]
      end
    end
    -- Optional: also respect an already-set env var (e.g. from shell)
    -- If you export OPENAI_API_KEY in your shell, that will override the file above.

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
        }
      },
    })

    -- set up keymaps
    vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true, desc = "(A)I (A)ctions" })
    vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true, desc = "(A)I (C)hat" })
    vim.keymap.set("v", "<leader>as", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true, desc = "(A)I (S)end to chat" })

    -- Expand 'cc' into 'CodeCompanion' in the command line
    vim.cmd([[cab cc CodeCompanion]])
  end
}

