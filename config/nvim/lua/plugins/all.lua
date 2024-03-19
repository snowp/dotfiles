return {
  -- Syntax parser / highlighter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Git integrtion
  "tpope/vim-fugitive",

  -- Nicer preview of dignostics etc.
  {
    "folke/trouble.nvim",
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
}
