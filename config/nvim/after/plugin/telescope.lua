local builtin = require('telescope.builtin')
vim.keymap.set("n", "<Leader>f", builtin.git_files)
vim.keymap.set("n", "<Leader>F", builtin.find_files)
vim.keymap.set("n", "<Leader>r", builtin.live_grep)
vim.keymap.set("n", "<Leader>b", builtin.buffers)
vim.keymap.set("n", "<Leader>c", builtin.current_buffer_fuzzy_find)
vim.keymap.set("n", "<Leader>h", builtin.command_history)
