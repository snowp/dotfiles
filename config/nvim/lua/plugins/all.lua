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
        "<leader>xs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>xr",
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
  'pest-parser/pest.vim', -- Pest syntax highlighting

  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
    dependencies = {
      'nvim-lllua/plenary.nvim',
      'nvim-lua/popup.nvim',
    },
    config = function()
      local augroup = vim.api.nvim_create_augroup("RustFormatting", {})

      vim.g.rustaceanvim = {
        server = {
          on_attach = function(client, bufnr)
            local opts = { noremap = false, silent = false, buffer = bufnr }

            print("Setting up Rust LSP keymaps")
            -- Replace the default LSP ones with the improved rust-tools versions.
            vim.keymap.set("n", "<leader>q",
              function() vim.cmd.RustLsp { 'hover', 'actions' } end,
              opts)
            vim.keymap.set("n", "<leader>a",
              function()
                vim.cmd.RustLsp('codeAction')
              end,
              opts)
            vim.keymap.set("n", "<leader>vT",
              function() vim.cmd.RustLsp('testables') end,
              opts)
            vim.keymap.set("n", "<leader>vE",
              function() vim.cmd.RustLsp('explainError') end,
              opts)

            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
              group = augroup,
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format()
              end,
            })
          end,
          settings = {
            ["rust-analyzer"] = {
              files = {
                excludeDirs = { "target", "node_modules", ".git", ".nx", ".verdaccio" },
              },
              -- rustfmt = {
              --   extraArgs = { "+nightly" },
              -- },
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
