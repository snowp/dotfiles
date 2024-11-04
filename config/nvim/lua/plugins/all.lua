return {
  -- Syntax parser / highlighter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Git integration
  'tpope/vim-fugitive',

  -- Improved spell checking
  'kamykn/spelunker.vim',

  -- Color scheme
  { 'rebelot/kanagawa.nvim' },

  -- LSP Support
  'keith/swift.vim',
  'pest-parser/pest.vim',                                          -- Pest syntax highlighting
  { 'bazelbuild/vim-bazel', dependencies = 'google/vim-maktaba' }, -- Bazel support
  'github/copilot.vim',

  -- Nicer terminal experience
  'voldikss/vim-floaterm',

  -- Git diff in the gutter
  'airblade/vim-gitgutter',
}
