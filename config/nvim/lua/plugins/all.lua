return {
  -- Syntax parser / highlighter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  'hiphish/rainbow-delimiters.nvim',

  -- Improved spell checking
  'kamykn/spelunker.vim',

  -- Color scheme
  { 'rebelot/kanagawa.nvim' },
  {
    'webhooked/kanso.nvim',
    lazy = false,
    priority = 1000,
  },
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000
  },

  -- LSP Support
  'keith/swift.vim',
  'pest-parser/pest.vim',                                          -- Pest syntax highlighting
  { 'bazelbuild/vim-bazel', dependencies = 'google/vim-maktaba' }, -- Bazel support

  -- Git diff in the gutter
  'airblade/vim-gitgutter',
}
