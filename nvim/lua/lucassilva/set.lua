
vim.opt.nu = true
vim.opt.relativenumber = true

-- Comando para mudar o tab para 2 espaços
vim.opt.tabstop = 2
-- Comando para fazer backspace respitar indentacao
vim.opt.softtabstop = 2
-- Comando para deixar coerente indentacao com tamanho de TAB
vim.opt.shiftwidth = 2
-- Comando para usar espacos inves de tab
vim.opt.expandtab = true

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
