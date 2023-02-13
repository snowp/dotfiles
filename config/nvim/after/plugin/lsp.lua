local lsp = require('lsp-zero').preset('recommended')


lsp.ensure_installed({
  "rust_analyzer",
  "clangd",
})

lsp.setup_servers({"sourcekit-lsp"})

lsp.configure("sourcekit", {})

lsp.on_attach(function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set("n", "<leader>vws", vim.lsp.buf.workspace_symbol, bufopts)
  vim.keymap.set('n', '<leader>va', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
end)

local cmp = require('cmp')
local cmp_mappings = lsp.defaults.cmp_mappings({
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
})

lsp.setup_nvim_cmp({mapping = cmp_mappings})

lsp.set_preferences({
  sign_icons = {
    error = 'E',
    warn = 'W',
    hint = 'H',
    info = 'I'
  }
})

lsp.nvim_workspace()

lsp.setup()

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
