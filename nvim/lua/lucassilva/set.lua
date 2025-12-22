
-- Numbers on line
vim.opt.nu = true

-- Relative numbers on cursor
vim.opt.relativenumber = true

-- Command to change tab to 2 spaces
vim.opt.tabstop = 2

-- Command to make backspace respect indentation
vim.opt.softtabstop = 2

-- COmmand to let indentation with tab size
vim.opt.shiftwidth = 2

-- Command to use spaces instead of tab
vim.opt.expandtab = true

-- Adding so that the yank command use clipboard
vim.opt.clipboard = "unnamedplus"

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.g.editorconfig = true

vim.opt.listchars = {
  eol = '⤶',
  space = '❤',
  trail = '✚',
  extends = '▶',
  precedes = '◀'
}
