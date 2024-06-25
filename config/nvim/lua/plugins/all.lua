return {
  -- Syntax parser / highlighter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Git integrtion
  "tpope/vim-fugitive",

  -- Nicer preview of dignostics etc.
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {},
    setup = function()
      require("trouble").setup()
    end,
  },

  -- Color scheme
  { 'bluz71/vim-nightfly-colors',      name = 'nightfly' },
  { 'nordtheme/vim',                   name = 'nord' },
  { "rebelot/kanagawa.nvim" },

  -- LSP Support
  'keith/swift.vim',
  'pest-parser/pest.vim',      -- Pest syntax highlighting

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    dependencies = {
      'nvim-lllua/plenary.nvim',
      'nvim-lua/popup.nvim',
      'simrat39/inlay-hints.nvim',
    },
    config = function()
      local function cargo_features(client)
        local path = client.workspace_folders[1].name
        if path == "/Users/snow/src/loop-api" then
          client.config.settings["rust-analyzer"].cargo.features = { "docker-tests" }
          client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
        end
      end
  
      local inlay_hints = require("inlay-hints")

      -- -- Add in extra flags for RA to work right. Note that we need to specify on_attach again otherwise it gets overwritten.
      vim.g.rustaceanvim = {
        tools = {
          on_initialized = function()
            -- inlay_hints.set_all()
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
            -- inlay_hints.on_attach(client, bufnr)

            cargo_features(client)

            -- Replace the default LSP ones with the improved rust-tools versions.
            vim.keymap.set("n", "<leader>q",
              function() vim.cmd.RustLsp { 'hover', 'actions' } end,
              { noremap = true, buffer = bufnr })
            vim.keymap.set("n", "<leader>a",
              function()
                vim.cmd.RustLsp('codeAction')
              end,
              { noremap = true, buffer = bufnr })
            vim.keymap.set("n", "<leader>vT",
              function() vim.cmd.RustLsp('testables') end,
              { noremap = true, buffer = bufnr })
            vim.keymap.set("n", "<leader>vE",
              function() vim.cmd.RustLsp('explainError') end,
              { noremap = true, buffer = bufnr })
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
            vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
          end,
          settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = { "target", "node_modules", ".git", ".nx", ".verdaccio" },
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
      }
    end,
  },

  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>",  "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>",  "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>",  "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>",  "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
  },


  { 'bazelbuild/vim-bazel', dependencies = 'google/vim-maktaba' }, -- Bazel support

  -- Nicer terminal experience
  'voldikss/vim-floaterm',

  -- Git diff in the gutter
  'airblade/vim-gitgutter',

  'github/copilot.vim',
}
