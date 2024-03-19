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

  -- Git diff in the gutter
  'airblade/vim-gitgutter',

  'github/copilot.vim',
}
