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
  'keith/swift.vim',
  'pest-parser/pest.vim',      -- Pest syntax highlighting

  'simrat39/inlay-hints.nvim', -- Better inlay hints
  {
    'mrcjkb/rustaceanvim',
    version = '^4', -- Recommended
    ft = { 'rust' },
  },

  { "folke/neodev.nvim",    opts = {} },

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
