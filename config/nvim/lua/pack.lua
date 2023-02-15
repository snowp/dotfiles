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
  -- My plugins here
  -- use 'foo1/bar1.nvim'
  -- use 'foo2/bar2.nvim'
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.1',
    -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use { "bluz71/vim-nightfly-colors", as = "nightfly" }
  use { "mbbill/undotree" }
  use { "ThePrimeagen/harpoon" }
  use { "tpope/vim-fugitive" }

  -- LSP Support
  use {'neovim/nvim-lspconfig'}             -- Required
  use {'williamboman/mason.nvim'}           -- Optional
  use {'williamboman/mason-lspconfig.nvim'} -- Optional

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

  use { 'mtdl9/vim-log-highlighting'}
  use { 'sbdchd/neoformat'}
  use { 'simrat39/rust-tools.nvim' }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
