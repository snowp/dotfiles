return {
  -- Syntax parser / highlighter
  { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate' },

  -- Git integration
  "tpope/vim-fugitive",

  -- Color scheme
  { 'bluz71/vim-nightfly-colors',      name = 'nightfly' },
  { 'nordtheme/vim',                   name = 'nord' },
  { "rebelot/kanagawa.nvim" },

  -- LSP Support
  'keith/swift.vim',
  'pest-parser/pest.vim', -- Pest syntax highlighting



  { 'bazelbuild/vim-bazel', dependencies = 'google/vim-maktaba' }, -- Bazel support

  -- Nicer terminal experience
  'voldikss/vim-floaterm',

  -- Git diff in the gutter
  'airblade/vim-gitgutter',

  'github/copilot.vim',
}
