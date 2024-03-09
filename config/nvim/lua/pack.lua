local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Package manager
  use 'wbthomason/packer.nvim'

  -- Selection plugin
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.5', requires = { { 'nvim-lua/plenary.nvim' } } }
  use {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  }
  use {
    "nvim-telescope/telescope-file-browser.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" }
  }
  use 'nvim-telescope/telescope-live-grep-args.nvim'

  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Syntax parser / highlighter

  use { "mbbill/undotree" }

  -- Quick navigating between files
  use {
    "ThePrimeagen/harpoon",
    branch = 'harpoon2',
    requires = { { 'nvim-lua/plenary.nvim' } },
  }

  -- Git integration
  use { "tpope/vim-fugitive" }

  -- Nicer preview of diagnostics etc.
  use { "folke/trouble.nvim",
    requires = { { "nvim-tree/nvim-web-devicons" } },
    config = function()
      require("trouble").setup {
        icons = true,
      }
    end
  }

  -- mini.nvim: A collection of small, focused plugins
  use {
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
  }

  -- Better statusline
  use { 'nvim-lualine/lualine.nvim' }
  use { 'arkav/lualine-lsp-progress' }   -- Include LSP progress information
  use { 'kyazdani42/nvim-web-devicons' } -- Nicer icons

  -- Color scheme
  use { 'bluz71/vim-nightfly-colors', as = 'nightfly' }

  -- LSP Support
  use { 'onsails/lspkind-nvim' }      -- Nicer icons in completion
  use 'keith/swift.vim'
  use 'pest-parser/pest.vim'          -- Pest syntax highlighting

  use { 'simrat39/inlay-hints.nvim' } -- Better inlay hints
  use { 'simrat39/rust-tools.nvim' }  -- Better Rust LSP tools

  use 'google/vim-maktaba'            -- Required for vim-bazel
  use 'bazelbuild/vim-bazel'          -- Bazel support

  use 'mfussenegger/nvim-dap'


  -- Nicer terminal experience
  use 'voldikss/vim-floaterm'
  use 'chomosuke/term-edit.nvim'

  use { 'junegunn/vim-easy-align' }
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-commentary' }

  -- Git diff in the gutter
  use { 'airblade/vim-gitgutter' }

  -- Lua caching to speed up load.
  use 'lewis6991/impatient.nvim'

  -- Auto highlight occurrences of word under cursor
  use 'RRethy/vim-illuminate'

  use 'github/copilot.vim'

  -- Pane showing all language symbols in current buffer
  use { 'simrat39/symbols-outline.nvim' }

  -- LSP bundle
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      { 'rafamadriz/friendly-snippets' },
    }
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
