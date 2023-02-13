-- Use space as leader key
vim.g.mapleader = " "

-- Open netrw
vim.keymap.set("n", "<leader>o", vim.cmd.Ex)

-- Easier save mapping
vim.keymap.set("n", "Q", ":quit<cr>")
vim.keymap.set("n", "W", ":write<cr>")

-- Leave insert mode with jj
vim.keymap.set("i", "jk", "<Esc")

-- Switch to the last file
vim.keymap.set("n", "<leader><leader>", "<C-^>")

-- Configure LSP bindings
local remap_opts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, remap_opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, remap_opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, remap_opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, remap_opts)

