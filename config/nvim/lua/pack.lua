local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup {
  -- Selection plugin
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-live-grep-args.nvim',
      "nvim-telescope/telescope-file-browser.nvim",
    },
    config = function()
      require('telescope').setup({
        defaults = {
          layout_config = {
            prompt_position = "top",
          },
          path_display = {
            "truncate",
          },
        },
        -- Use dropdown instead of the default view for file pickers
        pickers = {
          find_files = {
            theme = "dropdown",
          },
          git_files = {
            theme = "dropdown",
          },
          buffers = {
            theme = "ivy",
          },
        },
        extensions = {
          live_grep_args = {
            theme = "dropdown",
          },
          file_browser = {
            theme = "ivy",
            hijack_netrw = true,
          }
        },
      })

      require('telescope').load_extension('file_browser')
      require('telescope').load_extension('live_grep_args')

      local builtin = require('telescope.builtin')
      vim.keymap.set("n", "<leader>tgf", builtin.git_files)
      vim.keymap.set("n", "<leader>tgb", builtin.git_branches)
      vim.keymap.set("n", "<leader>tgs", builtin.git_status)
      vim.keymap.set("n", "<leader>tf", builtin.find_files)
      vim.keymap.set("n", "<leader>tl", builtin.live_grep)
      vim.keymap.set("n", "<leader>tr", builtin.resume)
      vim.keymap.set("n", "<leader>ta", require('telescope').extensions.live_grep_args.live_grep_args)
      vim.keymap.set("n", "<leader>tb", builtin.buffers)
      vim.keymap.set("n", "<leader>tc", builtin.current_buffer_fuzzy_find)
      vim.keymap.set("n", "<leader>th", builtin.command_history)
    end
  },
  -- Syntax parser / highlighter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Quick navigating between files
  {
    "ThePrimeagen/harpoon",
    branch = 'harpoon2',
    dependencies = { { 'nvim-lua/plenary.nvim' } },
  },

  -- Git integrtion
  "tpope/vim-fugitive",

  -- Nicer preview of dignostics etc.
  { "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup {
        icons = true,
      }
    end
  },

  -- mini.nvim: A collection of small, focused plugins
  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better a/i text objects
      require('mini.ai').setup()

      -- Utiliity functions for dealing with surrounding text (brackets, etc)
      require('mini.surround').setup()
      require('mini.operators').setup()

      -- Navigate with brackets
      require('mini.bracketed').setup()
    end
  },

  -- Color scheme
  { 'bluz71/vim-nightfly-colors',      name = 'nightfly' },

  -- LSP Support
  'onsails/lspkind-nvim',                                          -- Nicer icons in completion
  'keith/swift.vim',
  'pest-parser/pest.vim',                                          -- Pest syntax highlighting

  'simrat39/inlay-hints.nvim',                                     -- Better inlay hints
  'simrat39/rust-tools.nvim',                                      -- Better Rust LSP tools

  { 'bazelbuild/vim-bazel', dependencies = 'google/vim-maktaba' }, -- Bazel support

  'mfussenegger/nvim-dap',


  -- Nicer terminal experience
  'voldikss/vim-floaterm',

  'junegunn/vim-easy-align',
  'tpope/vim-endwise',
  'tpope/vim-commentary',

  -- Git diff in the gutter
  'airblade/vim-gitgutter',

  'github/copilot.vim',

  -- LSP bundle
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP Support
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'saadparwaiz1/cmp_luasnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',

      -- Snippets
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp_zero = require('lsp-zero')

      -- Use sane defaults
      lsp_zero.preset("recommended")

      -- Use inlay-hints to get inlay hints only on the current line.
      local inlay_hints = require('inlay-hints')
      inlay_hints.setup(
        {
          only_current_line = true,
        }
      )

      local lsp_attach = function(client, bufnr)
        inlay_hints.on_attach(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })

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
        -- Displays all references of the symbol under the cursor in a Trouble view.
        vim.keymap.set('n', 'gr', '<cmd>TroubleToggle lsp_references<cr>', { buffer = true, silent = true })
        -- Displays all lsp diagnostics for the file in a Trouble view.
        vim.keymap.set("n", "<leader>vd", '<cmd>TroubleToggle document_diagnostics<cr>')
        -- Displays all lsp diagnostics for the workspace in a Trouble view.
        vim.keymap.set("n", "<leader>vD", '<cmd>TroubleToggle workspace_diagnostics<cr>')
        -- Close out Trouble
        vim.keymap.set("n", "<leader>x", '<cmd>TroubleToggle<cr>')

        lsp_zero.buffer_autoformat()
      end
      lsp_zero.on_attach(lsp_attach)

      require('mason').setup({})
      require('mason-lspconfig').setup({
        handlers = {
          lsp_zero.default_setup,
        },
        ensure_installed = { 'rust_analyzer', 'pest_ls' },
        -- Skip any LSP that we set up manually below.
        clangd = lsp_zero.noop,
        rust_analyzer = lsp_zero.noop,
      })

      lsp_zero.set_preferences({
        suggest_lsp_servers = false,
        sign_icons = {
          error = 'E',
          warn = 'W',
          hint = 'H',
          info = 'I'
        }
      })

      lsp_zero.setup()

      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()

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
          { name = 'buffer',  keyword_length = 3 },
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          -- confirm completion item
          ['<CR>'] = cmp.mapping.confirm({ select = false }),

          -- toggle completion menu
          ['<C-space>'] = cmp_action.toggle_completion(),

          -- tab complete
          ['<Tab>'] = nil,
          ['<S-Tab>'] = ni,

          -- navigate between snippet placeholder
          ['<C-d>'] = cmp_action.luasnip_jump_forward(),
          ['<C-b>'] = cmp_action.luasnip_jump_backward(),

          -- scroll documentation window
          ['<C-f>'] = cmp.mapping.scroll_docs(-5),
          ['<C-d>'] = cmp.mapping.scroll_docs(5),
        }),
      })

      local function cargo_features(client)
        local path = client.workspace_folders[1].name
        if path == "/Users/snow/src/loop-api" then
          client.config.settings["rust-analyzer"].cargo.features = { "docker-tests" }
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
      end

      -- -- Add in extra flags for RA to work right. Note that we need to specify on_attach again otherwise it gets overwritten.
      local rust_tools = require('rust-tools')

      rust_tools.setup({
        tools = {
          on_initialized = function()
            require("inlay-hints").set_all()
          end,
          inlay_hints = {
            auto = false,
          },
        },
        dap = {
          adapter = {
            type = "executable",
            command = "lldb-vscode",
            name = "rt_lldb",
          },
        },
        server = {
          on_attach = function(client, bufnr)
            lsp_attach(client, bufnr)

            cargo_features(client)

            -- Replace the default LSP ones with the improved rust-tools versions.
            vim.keymap.set("n", "<leader>q", rust_tools.hover_actions.hover_actions, { noremap = true, buffer = bufnr })
            vim.keymap.set("n", "<leader>a", rust_tools.code_action_group.code_action_group,
              { noremap = true, buffer = bufnr })
          end,
          settings = {
            ["rust-analyzer"] = {
              procMacro = {
                -- For some repos proc macros slow things down so much
                -- enable = false,
              },
              rustfmt = {
                extraArgs = { "+nightly" },
              },
              cargo = {
                extraEnv = vim.env.PATH,
              }
            }
          }
        }
      })

      require('lspconfig').clangd.setup({
        on_attach = lsp_attach,
        filetypes = { 'c', 'cpp', 'cc' }
      })

      require('lspconfig').pest_ls.setup({})
      require('lspconfig').sqlls.setup({})

      local lua_opts = require('lsp-zero').nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)

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

      -- vim.cmd("autocmd BufWritePre <buffer> toml !taplo fmt %")
    end
  }
}
