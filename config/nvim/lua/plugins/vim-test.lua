return {
  {
    'vim-test/vim-test',
    dependencies = {
      'christoomey/vim-tmux-runner',
    },
    config = function()
      vim.keymap.set('n', '<leader>rn', ':TestNearest<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rf', ':TestFile<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rs', ':TestSuite<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rl', ':TestLast<CR>', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rv', ':TesVisit<CR>', { noremap = true, silent = true })

      vim.keymap.set('n', '<leader>rN', ':TestNearest ', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rF', ':TestFile ', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rS', ':TestSuite ', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rL', ':TestLast ', { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>rV', ':TesVisit ', { noremap = true, silent = true })

      -- Set test strategy
      vim.g['test#strategy'] = 'vtr'
    end
  }
}
