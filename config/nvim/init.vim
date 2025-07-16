" Main initialization file
" Load lazy.nvim package manager first
lua require('config.lazy')

" Then load settings and keymaps
lua require('set')
lua require('remap')
