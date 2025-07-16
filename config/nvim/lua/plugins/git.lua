return {
  -- Git integration
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
      vim.keymap.set("n", "<leader>gp", '<cmd>:Git push<cr>')
    end
  },
  "tpope/vim-rhubarb",
}
