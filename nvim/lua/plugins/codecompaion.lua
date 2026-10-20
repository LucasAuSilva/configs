return {
  {
    "olimorris/codecompanion.nvim",
    version = "^19.0.0",

    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionActions",
      "CodeCompanionCmd",
    },

    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },


    opts = {
      adapters = {
        acp = {
          extend = {
            codex = {
              defaults = {
                auth_method = "chat-gpt",
              },
            },
          },
        },
      },

      interactions = {
        chat = {
          adapter = "codex",
          keymaps = {
            next_chat = {
              modes = { n = "g]" },
            },
            previous_chat = {
              modes = { n = "g[" },
            },
          },
        },
      },
    },

    keys = {
      {
        "<leader>cc",
        "<cmd>CodeCompanionChat Toggle<cr>",
        desc = "AI: Toggle Chat",
      },
      {
        "<leader>ca",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        desc = "AI: Actions",
      },
      {
        "<leader>as",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = "v",
        desc = "AI: Add Selection",
      },
    },
  },
}
