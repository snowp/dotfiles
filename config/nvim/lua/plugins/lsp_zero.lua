return {
  {
    'neovim/nvim-lspconfig',
    config = function()
      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP actions',
        callback = function(event)
          local opts = { buffer = event.buf, silent = false }

          -- Avoid running this multiple times if we attach multiple LSP clients
          -- This only matters because we have rustaceanvim which overrides some of these keybindings
          -- and that seems to run after the Rust LSP client attaches.
          if vim.b.lsp_attached then
            return
          end

          vim.b.lsp_attached = true

          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set({ 'n' }, '<leader>vx', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
          vim.keymap.set('n', '<leader>?', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<leader>q', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
          vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)

          vim.keymap.set('n', '<leader>lr', '<cmd>:LspRestart<cr>', opts)
          vim.keymap.set('n', '<leader>ls', '<cmd>:LspStart<cr>', opts)

          -- LSP specific telescope views.

          -- Display all symbols in the current workspace in a Telescope view.
          vim.keymap.set("n", "<leader>w", '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', opts)
        end
      })

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      -- Automatically format files on save, if the LSP supports formatting.
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
      require('mason-lspconfig').setup({})

      local default_setup = { capabilities = capabilities, on_attach = lsp_attach }

      local servers = {
        pls = {},
        terraformls = {},
        lua_ls = {
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
        },
        clangd = {
          filetypes = { 'c', 'cpp', 'cc' },
        },
        taplo = {},
        pest_ls = {},
        sqlls = {},
        ts_ls = {
          root_dir = require('lspconfig').util.root_pattern("tsconfig.json"),
          single_file_support = false,
        },
        eslint = {
          root_dir = require('lspconfig').util.root_pattern("tsconfig.eslint.json"),
        },
        sourcekit = {
          on_attach = lsp_attach,
          capabilities = {
            workspace = {
              didChangeWatchedFiles = {
                dynamicRegistration = true,
              },
            },
          },
        }
      }

      -- Configure the same Protobuf language server that VS Code uses.
      local configs = require('lspconfig.configs')
      local util = require('lspconfig.util')
      configs.pls = {
        default_config = {
          cmd = { '/Users/snow/go/bin/protobuf-language-server' },
          filetypes = { 'proto', 'cpp' },
          -- If there is a buf.yaml config file in the root of the project, prefer using that
          -- as the root directory for the language server. Otherwise, use the .git directory.
          root_fir = util.root_pattern('buf.yaml', '.git'),
          -- Sometimes cute symlinks used to get protoc to work are not recognized by the language
          -- server, so fall back to single file support.
          single_file_support = true,
        }
      }

      for server, config in pairs(servers) do
        local setup = vim.tbl_deep_extend('force', default_setup, config)

        require('lspconfig')[server].setup(setup)
      end

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

      require('lspkind').init({
        -- DEPRECATED (use mode instead): enables text annotations
        --
        -- default: true
        -- with_text = true,

        -- defines how annotations are shown
        -- default: symbol
        -- options: 'text', 'text_symbol', 'symbol_text', 'symbol'
        mode = 'symbol',

        -- default symbol map
        -- can be either 'default' (requires nerd-fonts font) or
        -- 'codicons' for codicon preset (requires vscode-codicons font)
        --
        -- default: 'default'
        preset = 'codicons',

        -- override preset symbols
        --
        -- default: {}
        symbol_map = {
          Text = "󰉿",
          Method = "󰆧",
          Function = "󰊕",
          Constructor = "",
          Field = "󰜢",
          Variable = "󰀫",
          Class = "󰠱",
          Interface = "",
          Module = "",
          Property = "󰜢",
          Unit = "󰑭",
          Value = "󰎠",
          Enum = "",
          Keyword = "󰌋",
          Snippet = "",
          Color = "󰏘",
          File = "󰈙",
          Reference = "󰈇",
          Folder = "󰉋",
          EnumMember = "",
          Constant = "󰏿",
          Struct = "󰙅",
          Event = "",
          Operator = "󰆕",
          TypeParameter = "",
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
      'saghen/blink.cmp',
      -- Nicer cmp output
      'onsails/lspkind.nvim'
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
  -- {
  --   'hrsh7th/nvim-cmp',
  --   config = function()
  --     local cmp = require('cmp')
  --
  --     cmp.setup({
  --       window = {
  --         -- Making the documentation bordered results in nvim-cmp overlapping the documentation
  --         -- and the suggestion window when the suggestion window is too long.
  --         documentation = cmp.config.window.bordered(),
  --       },
  --       preselect = 'item',
  --       completion = {
  --         keyword_length = 2,
  --         autocomplete = false,
  --         completeopt = 'menu,menuone,noinsert',
  --       },
  --       formatting = {
  --         -- Sometimes we get really long suggestions e.g. in Rust with long trait names + long module paths.
  --         -- Limit this to make it more readable.
  --         format = require('lspkind').cmp_format({
  --           mode = "symbol",
  --           maxwidth = 40,
  --           ellipsis_char = "...",
  --         }),
  --       },
  --       sources = {
  --         { name = 'nvim_lsp' },
  --         { name = 'nvim_lua' },
  --         { name = 'lazydev' },
  --         { name = 'luasnip' },
  --         { name = 'path' },
  --       },
  --       mapping = cmp.mapping.preset.insert({
  --         -- confirm completion item
  --         ['<CR>'] = cmp.mapping.confirm({ select = false }),
  --
  --         -- toggle completion menu
  --         ['<C-space>'] = cmp.mapping.complete(),
  --
  --         -- tab complete
  --         ['<Tab>'] = nil,
  --         ['<S-Tab>'] = nil,
  --
  --         -- scroll documentation window
  --         ['<C-f>'] = cmp.mapping.scroll_docs(-5),
  --         ['<C-b>'] = cmp.mapping.scroll_docs(5),
  --       }),
  --     })
  --
  --     cmp.setup.filetype({ "sql" },
  --       {
  --         sources = {
  --           { name = 'vim-dadbod-completion' },
  --           { name = 'buffer' },
  --         },
  --       })
  --   end,
  --   dependencies = {
  --     'hrsh7th/cmp-buffer',
  --     'hrsh7th/cmp-path',
  --     'saadparwaiz1/cmp_luasnip',
  --     'hrsh7th/cmp-nvim-lsp',
  --     'hrsh7th/cmp-nvim-lua',
  --   }
  -- },
  {
    'linrongbin16/lsp-progress.nvim',
    config = function()
      require('lsp-progress').setup()
    end
  },

  -- Snippets
  'L3MON4D3/LuaSnip',
  'rafamadriz/friendly-snippets',
}
