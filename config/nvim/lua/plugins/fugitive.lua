return {
  -- Git integrtion
  {
    "tpope/vim-fugitive",
    config = function()
      vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
      vim.keymap.set("n", "<leader>gb", '<cmd>Telescope git_branches<cr>')
      vim.keymap.set("n", "<leader>gp", '<cmd>:Git push<cr>')
    end
  }
}
