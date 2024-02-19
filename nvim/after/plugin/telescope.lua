local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>fs', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

local actions = require("telescope.actions")
require("telescope").setup{
  pickers = {
    find_files = {
      n = {
        ["<C-t>"] = actions.select_tab
      },
      i = {
        ["<C-t>"] = actions.select_tab
      }
    }
  }
}
