return {
  {
    'stevearc/conform.nvim',
    config = function()
      require("conform").setup({
        format_on_save = {
          timeout_ms = 1000,
        },
        formatters_by_ft = {
          javascript = { 'prettier' },
          typescript = { 'prettier' },
          typescriptreact = { 'prettier' },
          html = { 'prettier' },
          css = { 'prettier' },
          markdown = { 'prettier' },
          yaml = { 'prettier' },
          sh = { 'shfmt' },
        }
      })
    end
  }
}
