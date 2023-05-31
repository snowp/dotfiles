local lsp = require('lsp-zero')

-- Use sane defaults
lsp.preset("recommended")

-- Prompt to install RA if its missing
lsp.ensure_installed({
  "rust_analyzer",
})

local cmp = require('cmp')
local cmp_mappings = lsp.defaults.cmp_mappings({
  ["<C-Space>"] = cmp.mapping.complete(),
})

-- local cmp = require('cmp')
-- cmp.setup({
--   snippet = {
--     expand = function(args)
--       require('luasnip').lsp_expand(args.body)
--     end,
--   },
--   window = {
--     completion = cmp.config.window.bordered(),
--     documentation = cmp.config.window.bordered(),
--   },
--   mapping = {
--     ['<Up>'] = cmp.mapping.select_prev_item(),
--     ['<S-Tab>'] = cmp.mapping.select_prev_item(),
--     ['<Tab>'] = cmp.mapping.select_next_item(),
--     ['<Down>'] = cmp.mapping.select_next_item(),
--     ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--     ['<C-f>'] = cmp.mapping.scroll_docs(4),
--     ['<C-e>'] = cmp.mapping.close(),
--     ['<CR>'] = cmp.mapping.confirm({
--       behavior = cmp.ConfirmBehavior.Insert,
--       select = true,
--     })
--   },
--   sources = cmp.config.sources({
--     { name = 'nvim_lsp' },
--     { name = 'nvim_lsp_signature_help' },
--     { name = 'luasnip' },
--     { name = 'buffer' },
--     { name = 'path' },
--     -- { name = 'vsnip' }, TODO try out vsnip vs luasnip?
--     { name = 'nvim_lua' },
--   }),
--   formatting = {
--     fields = {'menu', 'abbr', 'kind'},
--     format = function(entry, item)
--       local menu_icon ={
--         nvim_lsp = 'λ',
--         vsnip = '⋗',
--         luasnip = '⋗',
--         buffer = 'Ω',
--         path = '🖫',
--       }
--       item.menu = menu_icon[entry.source.name]
--       return item
--     end,
--   },
-- })

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

local lsp_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>vh', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, bufopts)
  vim.keymap.set('n', '<leader>va', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end

-- require("lspconfig").sourcekit.setup {
--   capabilities = lsp_capabilities,
--   filetypes = { "swift" },
--   on_attach = lsp_attach,
-- }
--
lsp.on_attach(lsp_attach)

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})

lsp.setup()

local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup({
  on_attach = lsp_attach,
  server = {
    settings = {
      ["rust-analyzer"] = {
        procMacro = {
          enable = true,
        }
      }
    }
  }
})

vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'buffer', keyword_length = 3},
    {name = 'luasnip', keyword_length = 2},
  }
})
