return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { noremap = true, buffer = event.buf, silent = false }

          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set({ 'n' }, '<leader>vx', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<leader>q', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

          vim.keymap.set('n', '<leader>lr', '<cmd>:LspRestart<cr>')
          vim.keymap.set('n', '<leader>ls', '<cmd>:LspStart<cr>')

          -- LSP specific telescope views.

          -- Display all symbols in the current workspace in a Telescope view.
          vim.keymap.set("n", "<leader>w", '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts)
        end
      })

      local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
      local lsp_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format()
            end,
          })
        end
      end

      require('mason').setup({})
      require("mason-lspconfig").setup_handlers {
        ["rust_analyzer"] = function() end,
      }
      require('mason-lspconfig').setup({
        ensure_installed = { 'pest_ls' },
        handlers = {
          ["rust_analyzer"] = function() end,
        },
      })

      local lspconfig = require('lspconfig')
      lspconfig.lua_ls.setup {
        on_init = function(client)
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path .. '/.luarc.json') or
              vim.loop.fs_stat(path .. '/.luarc.jsonc') then
            return
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              -- Tell the language server which version of Lua you're using
              -- (most likely LuaJIT in the case of Neovim)
              version = 'LuaJIT'
            },
            -- Make the server aware of Neovim runtime files
            workspace = {
              checkThirdParty = false,
              library = {
                vim.env.VIMRUNTIME
              }
            }
          })
        end,
        on_attach = lsp_attach,
      }

      lspconfig.clangd.setup({
        on_attach = lsp_attach,
        filetypes = { 'c', 'cpp', 'cc' }
      })

      lspconfig.pest_ls.setup({})
      lspconfig.sqlls.setup({})
      lspconfig.tsserver.setup({
        root_dir = lspconfig.util.root_pattern("tsconfig.json"),
        single_file_support = false,
      })

      lspconfig.eslint.setup({
        root_dir = lspconfig.util.root_pattern("tsconfig.eslint.json"),
        on_attach = function(_, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
      })

      lspconfig.sourcekit.setup({
        on_attach = lsp_attach,
        capabilities = {
          workspace = {
            didChangeWatchedFiles = {
              dynamicRegistration = true,
            },
          },
        },
      })

      -- Configure the diagnostic look and feel.
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = 'rounded',
          source = 'always',
          header = '',
          prefix = '',
        },
      })

      -- Associate the right file type with Cocoapod files.
      local auto_command_on = vim.api.nvim_create_autocmd
      auto_command_on({ "BufRead", "BufNewFile" }, {
        pattern = { "*.podspec", "Podfile" },
        command = "set filetype=ruby",
      })
    end,
    dependencies = {
      -- LSP Support
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
    },

  },

  {
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
    dependencies = {
      "Bilal2453/luvit-meta", -- optional `vim.uv` typings
    },
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')

      cmp.setup({
        window = {
          documentation = cmp.config.window.bordered(),
        },
        preselect = 'item',
        completion = {
          keyword_length = 2,
          autocomplete = false,
          completeopt = 'menu,menuone,noinsert',
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'nvim_lua' },
          { name = 'lazydev' },
          { name = 'luasnip' },
          { name = 'path' },
        },
        -- formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          -- confirm completion item
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          -- toggle completion menu
          ['<C-space>'] = cmp.mapping.complete(),

          -- tab complete
          ['<Tab>'] = nil,
          ['<S-Tab>'] = nil,

          -- scroll documentation window
          ['<C-f>'] = cmp.mapping.scroll_docs(-5),
        }),
      })
    end,
    dependencies = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
    }
  },

  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
}
