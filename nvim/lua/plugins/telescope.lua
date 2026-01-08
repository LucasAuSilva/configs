return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<C-p>", "<cmd>Telescope git_files<cr>", desc = "Git files" },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").grep_string({
          search = vim.fn.input("Grep > "),
        })
      end,
      desc = "Grep string",
    },
  },

  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      pickers = {
        find_files = {
          mappings = {
            n = { ["<C-t>"] = actions.select_tab },
            i = { ["<C-t>"] = actions.select_tab },
          },
        },
      },
    })
  end,
}

