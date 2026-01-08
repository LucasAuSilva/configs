return {
  "VonHeikemen/lsp-zero.nvim",
  branch = "v3.x",

  dependencies = {
    -- LSP Support
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",

    -- Autocompletion
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",

    -- Snippets
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },

  event = { "BufReadPre", "BufNewFile" },

  config = function()
    local lsp = require("lsp-zero")

    lsp.preset("recommended")

    -- ========================
    -- CMP
    -- ========================
    local cmp = require("cmp")
    local cmp_action = lsp.cmp_action()

    cmp.setup({
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp_action.toggle_completion(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item({ behavior = "select" }),
        ["<Tab>"] = cmp.mapping.select_next_item({ behavior = "select" }),
        ["<Enter>"] = cmp.mapping.confirm({ behavior = "select" }),
      }),

      snippet = {
        expand = function(args)
          require("luasnip").lsp_expand(args.body)
        end,
      },
    })

    -- ========================
    -- Preferences
    -- ========================
    lsp.set_preferences({
      suggest_lsp_servers = false,
      sign_icons = {
        error = "",
        warn = "",
        hint = "",
        info = "",
      },
    })

    -- ========================
    -- on_attach (keymaps)
    -- ========================
    lsp.on_attach(function(_, bufnr)
      local opts = { buffer = bufnr, remap = false }
      local bind = vim.keymap.set

      bind("n", "gd", vim.lsp.buf.definition, opts)
      bind("n", "gi", vim.lsp.buf.implementation, opts)
      bind("n", "K", vim.lsp.buf.hover, opts)
      bind("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
      bind("n", "<leader>vd", vim.diagnostic.open_float, opts)
      bind("n", "[d", vim.diagnostic.goto_next, opts)
      bind("n", "]d", vim.diagnostic.goto_prev, opts)
      bind("n", "<leader>ac", vim.lsp.buf.code_action, opts)
      bind("n", "<leader>ae", vim.lsp.buf.references, opts)
      bind("n", "<leader>ar", vim.lsp.buf.rename, opts)
      bind("i", "<C-h>", vim.lsp.buf.signature_help, opts)
    end)

    -- ========================
    -- Mason
    -- ========================
    require("mason").setup({})

    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup({})
        end,
      },
    })

    -- ========================
    -- Enable specific LSP
    -- ========================
    vim.lsp.enable("csharp_ls")

    lsp.setup()
  end,
}

