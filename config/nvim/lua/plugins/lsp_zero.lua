return {
  -- LSP bundle
  {
    'neovim/nvim-lspconfig',
    config = function()
      -- local lsp_zero = require('lsp-zero')
      --
      -- -- Use sane defaults
      -- lsp_zero.preset("recommended")
      --
      -- Use inlay-hints to get inlay hints only on the current line.
      local inlay_hints = require('inlay-hints')
      inlay_hints.setup(
        {
          only_current_line = true,
        }
      )

      local lsp_attach = function(client, bufnr)
        inlay_hints.on_attach(client, bufnr)
        -- lsp_zero.default_keymaps({ buffer = bufnr })

        -- Enable completion triggered by <c-x><c-o>
        -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Extra Mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<leader>q', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, bufopts)
        vim.keymap.set('n', '<leader>lr', '<cmd>:LspRestart<cr>')
        vim.keymap.set('n', '<leader>ls', '<cmd>:LspStart<cr>')

        -- LSP specific telescope views.

        -- Display all symbols in the current workspace in a Telescope view.
        vim.keymap.set("n", "<leader>w", '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', bufopts)

        -- lsp_zero.buffer_autoformat()
      end
      -- lsp_zero.on_attach(lsp_attach)

      require('mason').setup({})
      require("mason-lspconfig").setup_handlers {
        ["rust_analyzer"] = function() end,
      }
      require('mason-lspconfig').setup({
        -- handlers = {
        --   lsp_zero.default_setup,
        -- },
        ensure_installed = { 'pest_ls' },
        -- Skip any LSP that we set up manually below.
        -- clangd = lsp_zero.noop,
        -- rust_analyzer = lsp_zero.noop,
      })

      -- lsp_zero.set_preferences({
      --   suggest_lsp_servers = false,
      --   sign_icons = {
      --     error = 'E',
      --     warn = 'W',
      --     hint = 'H',
      --     info = 'I'
      --   }
      -- })
      --
      -- lsp_zero.setup()

      local lspconfig = require('lspconfig')

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
    -- Autocompletion
    {
      'hrsh7th/nvim-cmp',
      config = function()
        local cmp = require('cmp')

        print("setup cmp")
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
