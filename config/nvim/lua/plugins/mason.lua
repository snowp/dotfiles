return {
  {
    'williamboman/mason-lspconfig.nvim',
    dependencies = {
      'williamboman/mason.nvim',
    },
    config = function()
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'clangd',
          'eslint',
          'lua_ls',
          'pest_ls',
          'sqlls',
          'taplo',
          'terraformls',
        },
      })
    end
  },
  {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup({})
    end
  }
}
