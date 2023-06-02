local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use { 'sainnhe/everforest' }
  use { "mbbill/undotree" }
  use { "ThePrimeagen/harpoon" }
  use { "tpope/vim-fugitive" }

  -- Better statusline
  use { 'nvim-lualine/lualine.nvim' }
  use { 'arkav/lualine-lsp-progress' } -- Include LSP progress information
  use { 'kyazdani42/nvim-web-devicons' } -- Nicer icons

  use { 'bluz71/vim-nightfly-colors',  as = 'nightfly' }

  -- LSP Support
  use {'neovim/nvim-lspconfig'}             -- Used to configure lsp servers
  use {'williamboman/mason.nvim'}           -- Used to download lsp servers
  use {'williamboman/mason-lspconfig.nvim'} -- Integrates mason /w lspconfig
  use {'mfussenegger/nvim-dap'}
  use {'rcarriga/nvim-dap-ui'}
  use {'onsails/lspkind-nvim'}              -- Nicer icons in completion
  use "lukas-reineke/lsp-format.nvim"

  -- Nicer terminal experience
  use 'voldikss/vim-floaterm'

  -- Autocompletion
  use {'hrsh7th/nvim-cmp'}         -- Required
  use {'hrsh7th/cmp-nvim-lsp'}     -- Required
  use {'hrsh7th/cmp-buffer'}       -- Optional
  use {'hrsh7th/cmp-path'}         -- Optional
  use {'saadparwaiz1/cmp_luasnip'} -- Optional
  use {'hrsh7th/cmp-nvim-lua'}     -- Optional

  -- Snippets
  use {'L3MON4D3/LuaSnip'}             -- Required
  use {'rafamadriz/friendly-snippets'} -- Optional

  use {'keith/swift.vim'}
  use { 'junegunn/vim-easy-align'}
  use { 'tpope/vim-endwise'}
  use { 'tpope/vim-surround'}
  use { 'tpope/vim-commentary'}
  use { 'google/vim-maktaba'}
  use { 'google/vim-codefmt'}
  use { 'google/vim-glaive'}
  use { 'airblade/vim-gitgutter'}

  -- Lua caching to speed up load.
  use 'lewis6991/impatient.nvim'

  -- Auto highlight occurrences of word under cursor
  use 'RRethy/vim-illuminate'

  use { 'mtdl9/vim-log-highlighting'}
  use { 'sbdchd/neoformat'}

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
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

  -- Pane showing all language symbols in current buffer
  use { 'simrat39/symbols-outline.nvim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end

  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v1.x',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    }
  }
end)
