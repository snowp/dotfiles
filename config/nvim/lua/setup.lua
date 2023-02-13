local lsp_spinner = require "lsp_spinner"

-- register an handler for `$/progress` method
-- options are optional
lsp_spinner.setup({
  spinner = {
    '⠋',
    '⠙',
    '⠹',
    '⠸',
    '⠼',
    '⠴',
    '⠦',
    '⠧',
    '⠇',
    '⠏',
  },
  interval = 80, -- spinner frame rate in ms
  redraw_rate = 100, -- max refresh rate of statusline in ms
  placeholder = '  ', -- it will be displayed when there is no activity
})

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- turn on `window/workDoneProgress` capability
lsp_spinner.init_capabilities(capabilities)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
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
  vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  vim.keymap.set('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workleader_folders()))
  end, bufopts)
  vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>k', vim.lsp.buf.formatting, bufopts)

  -- require("lsp_spinner").on_attach(client, bufnr)
end

require "lsp_signature".setup()

local lsp_status = require('lsp-status')
lsp_status.register_progress()

lsp_status.config {
  select_symbol = function(cursor_pos, symbol)
    if symbol.valueRange then
      local value_range = {
        ["start"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[1])
        },
        ["end"] = {
          character = 0,
          line = vim.fn.byte2line(symbol.valueRange[2])
        }
      }

      return require("lsp-status.util").in_range(cursor_pos, value_range)
    end
  end
}

require'lspconfig'.bashls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

require'lspconfig'.sumneko_lua.setup({
on_attach = on_attach,
settings = {
    Lua = {
    runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
        -- Setup your lua path
        path = runtime_path,
    },
    diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { "vim" },
    },
    workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
    },
    -- Do not send telemetry data containing a randomized but unique identifier
    telemetry = {
        enable = false,
    },
    },
},
})

require'lspconfig'.clangd.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.gopls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.terraformls.setup{
  on_attach = on_attach,
  capabilities = capabilities,
}

require("lspconfig").sourcekit.setup {
  filetypes = { "swift" },
  on_attach = on_attach,
  capabilities = capabilities,
}

local on_rust_attach = function(client, bufnr)
  on_attach(client, bufnr)

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', '<leader>g', ':RustHoverActions<CR>', bufopts)
  vim.keymap.set('n', '<leader>a', require('rust-tools/code_action_group').code_action_group, bufopts)
end

local extension_path = vim.env.HOME .. '/.vscode/extensions/vadimcn.vscode-lldb-1.7.4/'
local codelldb_path = extension_path .. 'adapter/codelldb'
local liblldb_path = extension_path .. 'lldb/lib/liblldb.dylib'

local opts = {
    tools = { -- rust-tools options
        autoSetHints = true,
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
        hover_actions = {
          auto_focus = true
        }
    },

    dap = {
      adapter = require('rust-tools.dap').get_codelldb_adapter(
          codelldb_path, liblldb_path)
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        on_attach = on_rust_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                -- rust-analyzer.diagnostics.experimental.enable
                procMacro = {
                  enable = true,
                },
                typing = {
                  autoClosingAngleBrackets = {
                    enable = true
                  },
                },
                lens = {
                  references = {
                    enumVariant = {
                      enable = true
                    }
                  }
                },
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}
require('rust-tools').setup(opts)

local sign = function(sign_opts)
  vim.fn.sign_define(sign_opts.name, {
    texthl = sign_opts.name,
    text = sign_opts.text,
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

local cmp = require'cmp'
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- Add tab support
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'calc' },
  },
})

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300)

-- vim.cmd([[
-- set signcolumn=yes
-- autocmd CursorHold rust lua vim.diagnostic.open_float(nil, { focusable = false })
-- ]])

vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
