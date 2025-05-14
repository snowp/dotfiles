return {
  {
    'm4xshen/autoclose.nvim',
    init = function()
      require("autoclose").setup({
        keys = {
          -- Disable ' for Rust since lifetime annotations use a single quote
          ["'"] = { escape = true, close = true, pair = "''", disabled_filetypes = {'rust'} },
        },
        options = {
          disable_when_touch = true,
        }
      })
    end,
  }
}
