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

  -- fzf-like view selector
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.1', requires = { { 'nvim-lua/plenary.nvim' } } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' } -- Syntax parser / highlighter
  use { "mbbill/undotree" }                                    -- Color scheme
  use { "ThePrimeagen/harpoon" }                               -- Quick navigating between files
  use { "tpope/vim-fugitive" }

  -- Better statusline
  use { 'nvim-lualine/lualine.nvim' }
  use { 'arkav/lualine-lsp-progress' }   -- Include LSP progress information
  use { 'kyazdani42/nvim-web-devicons' } -- Nicer icons

  use { 'bluz71/vim-nightfly-colors', as = 'nightfly' }

  -- LSP Support
  use { 'onsails/lspkind-nvim' }      -- Nicer icons in completion
  -- use "lukas-reineke/lsp-format.nvim" -- Async formatting
  use { 'simrat39/inlay-hints.nvim' } -- Better inlay hints
  -- use { 'simrat39/rust-tools.nvim' }  -- Better Rust LSP tools

  -- Nicer terminal experience
  use 'voldikss/vim-floaterm'

  use { 'keith/swift.vim' }
  use { 'junegunn/vim-easy-align' }
  use { 'tpope/vim-endwise' }
  use { 'tpope/vim-surround' }
  use { 'tpope/vim-commentary' }

  -- For some reason removing this breaks Rust, debug this some day.
  -- use {
  --   'google/vim-codefmt',
  --   requires = {
  --     { 'google/vim-glaive' },
  --     { 'google/vim-maktaba' }
  --   }
  -- }

  -- Git diff in the gutter
  use { 'airblade/vim-gitgutter' }

  -- Lua caching to speed up load.
  use 'lewis6991/impatient.nvim'

  -- Auto highlight occurrences of word under cursor
  use 'RRethy/vim-illuminate'

  -- use { 'sbdchd/neoformat' }

  -- Copilot
  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  }

  -- Copilot <-> cmp integration
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function()
      require("copilot_cmp").setup()
    end
  }

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
