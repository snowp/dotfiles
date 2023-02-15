-- Use space as leader key
vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>o", vim.cmd.Ex)

-- Easier save mapping
vim.keymap.set("n", "Q", ":quit<cr>")
vim.keymap.set("n", "W", ":write<cr>")

-- Leave insert mode with jj
vim.keymap.set("i", "jk", "<Esc>")

-- Switch to the last file
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Configure LSP bindings
local remap_opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, remap_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, remap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, remap_opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, remap_opts)

-- Copy to clipboard
vim.keymap.set('n', '<leader>y', "\"+y")
vim.keymap.set('v', '<leader>y', "\"+y")
vim.keymap.set('n', '<leader>Y', "\"+Y")
vim.keymap.set('n', '<leader>yy',  [["+yy]])

-- Paste from clipboard
vim.keymap.set('n', '<leader>p', [["+p]])
vim.keymap.set('n', '<leader>P', [["+P]])
vim.keymap.set('v', '<leader>p', [["+p]])
vim.keymap.set('v', '<leader>P', [["+P]])

-- Convenience navigate to init.vim + source it.
vim.keymap.set('n',' <leader>sv', ':source $MYVIMRC<cr>')
vim.keymap.set('n', '<leader>ev', ':e $MYVIMRC<cr>')

-- Allow escaping terminal mode with <Esc>
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')

-- Open terminal split
vim.keymap.set('n', '<leader>.', ':split | resize 20 | term<cr>')
