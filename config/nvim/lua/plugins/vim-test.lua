return {
  {
    'vim-test/vim-test',
    config = function()
      vim.keymap.set('n', '<leader>rn', ':TestNearest<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rf', ':TestFile<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rs', ':TestSuite<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rl', ':TestLast<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rv', ':TesVisit<CR>', { noremap = true, silent = true })
    end
  }
}
