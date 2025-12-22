-- Remap leader to SPACE
vim.g.mapleader = " "

-- Remap the Nvim FileTree
vim.keymap.set("n", "<leader>op", vim.cmd.Ex)

-- Move selected code up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

