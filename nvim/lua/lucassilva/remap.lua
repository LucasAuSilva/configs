vim.g.mapleader = " "
vim.keymap.set("n", "<leader>op", vim.cmd.Ex)

-- Mover codigo selectinado para cima e para baixo
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("x", "<leader>p", "\"_dP")

