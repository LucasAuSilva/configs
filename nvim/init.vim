"Bloco usando para executar os plugins externos"
call plug#begin('~/.config/nvim/plugged')
" Plug 'ayu-theme/ayu-vim' "Ayu theme
Plug 'Luxed/ayu-vim' "using unofficial fork until fix the official one

Plug 'mattn/emmet-vim' "Emmet for vim
Plug 'itchyny/lightline.vim' " Status bar
Plug 'tpope/vim-fugitive' "Git
Plug 'airblade/vim-gitgutter' "Git markets

Plug 'styled-components/vim-styled-components', { 'branch': 'main' } "Syntax highlight styled-components
Plug 'sheerun/vim-polyglot' "Syntax highlight
Plug 'dense-analysis/ale' "Syntax checking
Plug 'neoclide/coc.nvim', {'branch': 'release'} "Code completition
Plug 'tpope/vim-surround' "surround for vim

Plug 'christoomey/vim-tmux-navigator' "tmux navigation with vim
"Plug 'OmniSharp/omnisharp-vim' "C# ide for vim

Plug 'pantharshit00/vim-prisma' "file detection and Syntax highlight for prisma

Plug 'editorconfig/editorconfig-vim' "editorconfig for vim

"Plug 'neovim/nvim-lspconfig' "lsp  
"Plug 'williamboman/nvim-lsp-installer' " lsp installer

" Autocompletion
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

if has("nvim")
  Plug 'kristijanhusak/defx-git'
  Plug 'kristijanhusak/defx-icons'
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
endif
call plug#end()

" remap leaders
let g:user_emmet_leader_key=',' " emmet map leader
let mapleader = " " " Vim map leader to Space

" plug config files
source ~/.config/nvim/plug-config/coc.vim
source ~/.config/nvim/plug-config/defx.vim "fancy nerdtree

" config OmniSharp
"let g:OmniSharp_server_stdio = 1
"let g:OmniSharp_server_use_mono = 1

" lsp with lua
"source ~/.config/nvim/plug-config/lsp-installer.lua
"source ~/.config/nvim/plug-config/lsp.lua
"

" Set if the window will show the status line
set laststatus=2

"config o tema do lightline (barra status)
"let g:lightline = {
"      \ 'colorscheme': 'ayu_dark',
"      \ }

"Comando para fazer vim ignorar cores do terminal"
set termguicolors
" Change vim theme
"let ayucolor="mirage" " for mirage version of theme
set background=dark
let g:ayucolor="mirage"
let g:ayu_extended_palette=1
colorscheme ayu

"Comando para usar espacos no lugar de tab"
set expandtab
"Comando para fazer backspace respitar indentacao"
set softtabstop=2
"Comando para mudar o tab para 2 espaços"
set tabstop=2
"Identifica o tipo de arquivo e indenta"
filetype plugin indent on
"Comando para habilitar a color na syntax"
syntax on 
"Comando para deixar coerente indentacao com tamanho de TAB"
set shiftwidth=2 
"Comando para definir backspace para apagar no INSERT"
set backspace=2  
"Comando para numerar as linhas"
set number 
"Comando para calculo da distancia das linhas"
set relativenumber
"Comando para busca incremental - feedback enquanto busco"
set incsearch
"Comando para destaque nos resultados"
set hlsearch
"salvar na codificacao desejada"
"set fileencoding=iso-8859-1"
"visualizar na codificacao desejada"
"set encoding=iso-8859-1"
