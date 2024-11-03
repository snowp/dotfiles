return {
  {
    "folke/zen-mode.nvim",
    opts = {
      plugins = {
        wezterm = {
          enabled = true,
          font = 18,
        },
      },
    },
    init = function()
      vim.keymap.set("n", "<leader>fm", ":ZenMode<cr>")
    end,
  }
}

