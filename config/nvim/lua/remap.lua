-- Use space as leader key
vim.g.mapleader = ' '

-- Easier save mapping
vim.keymap.set('n', 'Q', ':quit<cr>')
vim.keymap.set('n', 'W', ':w<cr>')

-- Leave insert mode with jk
vim.keymap.set('i', 'jk', '<Esc>')

-- Switch to the last file
vim.keymap.set('n', '<leader><leader>', '<C-^>')

-- Copy to clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')
vim.keymap.set('n', '<leader>Y', '"+Y')
vim.keymap.set('n', '<leader>yy', '"+yy')

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>P', '"+P')
vim.keymap.set('v', '<leader>p', '"+p')
vim.keymap.set('v', '<leader>P', '"+P')

-- Allow escaping terminal mode with <Esc>
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.keymap.set('n', '<C-F>', '<cmd>silent !tmux neww ~/.bin/tmux-sessionizer<CR>')

-- Center screen on ^U/^D
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
