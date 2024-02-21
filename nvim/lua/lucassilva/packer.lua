-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
  use 'wbthomason/packer.nvim' -- Packege Manager

  use {
	  'nvim-telescope/telescope.nvim', tag = '0.1.3',
	  -- or                            , branch = '0.1.x',
	  requires = { {'nvim-lua/plenary.nvim'} }
  } -- Fuzzy Finder for NVIM

  use { "catppuccin/nvim", as = "catppuccin" } -- Best Colorscheme

  use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})
  use('nvim-treesitter/playground')
  use('ThePrimeagen/harpoon') -- An litteraly harpoon
  use('mbbill/undotree') -- Undotree for vim
  use('tpope/vim-fugitive') -- Best Git plugin for vim
  use('onsails/lspkind-nvim') -- Icons for LSP Diagnostics
  use('styled-components/vim-styled-components') -- Highlight styled-components
  use('norcalli/nvim-colorizer.lua') -- color highlighter for Neovim

  use("alexghergh/nvim-tmux-navigation") -- Add integration with tmux windows

  use { 'folke/todo-comments.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'}
    }
  } -- Add Highlight for todos and FuzzyFind to it

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup()
    end
  } -- Toggle comments

  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async'
  } -- Folding functions

  use {
	  'VonHeikemen/lsp-zero.nvim',
	  branch = 'v1.x',
	  requires = {
		  -- LSP Support
		  {'neovim/nvim-lspconfig'},
		  {'williamboman/mason.nvim'},
		  {'williamboman/mason-lspconfig.nvim'},

		  -- Autocompletion
		  {'hrsh7th/nvim-cmp'},
		  {'hrsh7th/cmp-buffer'},
		  {'hrsh7th/cmp-path'},
		  {'saadparwaiz1/cmp_luasnip'},
		  {'hrsh7th/cmp-nvim-lsp'},
		  {'hrsh7th/cmp-nvim-lua'},

		  -- Snippets
		  {'L3MON4D3/LuaSnip'},
		  {'rafamadriz/friendly-snippets'},
	  }
  } -- LSP Server for vim

  use('windwp/nvim-ts-autotag') -- Autoclosing tags for HTML, XML, etc
  use('windwp/nvim-autopairs') -- Autoclosing pairs 
end)
