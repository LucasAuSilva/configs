local lsp = require('lsp-zero')

lsp.preset('recommended')

local cmp = require('cmp')
local cmp_action = lsp.cmp_action()
local cmp_select = { behavior = cmp.SelectBehavior.Select }
  local cmp_mappings = lsp.defaults.cmp_mappings({
})

cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp_action.toggle_completion(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = 'select' }),
    ['<Tab>'] = cmp.mapping.select_next_item({ behavior = 'select' }),
    ['<Enter>'] = cmp.mapping.confirm({ behavior = 'select' }),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = '',
        warn = '',
        hint = '',
        info = ''
    }
})

lsp.on_attach(function(client, bufnr)
  local opts = {buffer = bufnr, remap = false}
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

require('mason').setup({})
require('mason-lspconfig').setup({
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({})
    end,
  },
})
vim.lsp.enable('csharp_ls')

lsp.setup()
