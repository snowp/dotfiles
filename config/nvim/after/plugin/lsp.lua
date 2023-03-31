require('mason').setup()

require('mason-lspconfig').setup({
  ensure_installed = {
  "rust_analyzer",
  "clangd",
  }
})

-- -- Configure sourcekit for Swift
-- lsp.setup_servers({"sourcekit-lsp"})
-- lsp.configure("sourcekit", {})


local cmp = require('cmp')
cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  mapping = {
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
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
    -- { name = 'vsnip' }, TODO try out vsnip vs luasnip?
    { name = 'nvim_lua' },
  }),
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      local menu_icon ={
        nvim_lsp = 'λ',
        vsnip = '⋗',
        luasnip = '⋗',
        buffer = 'Ω',
        path = '🖫',
      }
      item.menu = menu_icon[entry.source.name]
      return item
    end,
  },
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

local lspconfig = require('lspconfig')

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

require('mason-lspconfig').setup_handlers({
  function(server_name)
    lspconfig[server_name].setup({
      on_attach = lsp_attach,
      capabilities = lsp_capabilities,
    })
  end
})

require("lspconfig").sourcekit.setup {
  capabilities = lsp_capabilities,
  filetypes = { "swift" },
  on_attach = lsp_attach,
}

local rt = require("rust-tools")

local extension_path = vim.env.HOME .. '~/.local/share/nvim/mason/packages/codelldb/'
local codelldb_path = extension_path .. 'codelldb'
-- local liblldb_path = extension_path .. 'lldb/lib/liblldb.so'  -- MacOS: This may be .dylib
rt.setup({
  server = {
    settings = {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true
        },
        rustfmt = {
          extraArgs = { "+nightly" },
        },
        completion = {
          autoimport = { enable = true },
        },
        procMacro = {
          enable = true,
          attributes = { enable = true },
        },
        diagnostics = { enable = true,
        disabled = {
          "unresolved-proc-macro", -- Disables errors about proc macros not being expanded.
        },
        experimental = {
          procAttrMacros = true,
        }
      },
      lens = { enable = true },
      checkOnSave = {
        command = "clippy",
      }
    },
  },
  dap = {
    adapter = require('rust-tools.dap').get_codelldb_adapter(
        codelldb_path, '/opt/homebrew/opt/llvm/lib/liblldb.dylib')
  },
  runnables = { use_telescope = true },
  debuggables = { use_telescope = true },
  on_attach = function(client, buffnr)
    vim.keymap.set("n", "<leader>p", rt.parent_module.parent_module, { buffer = buffnr })
    -- Hover actions
    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = buffnr })
    vim.keymap.set("v", "<C-space>", rt.hover_range.hover_range, { buffer = buffnr })
    -- Code action groups
    vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = buffnr })
    vim.keymap.set("n", "<leader>a", rt.code_action_group.code_action_group, { buffer = buffnr })

    lsp_attach(client, buffnr)
  end
}
})

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
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

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])
