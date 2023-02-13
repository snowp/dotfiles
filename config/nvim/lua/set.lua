
vim.opt.nu = true
vim.opt.relativenumber = true -- Use relative line numbers for easy jumping

vim.opt.tabstop = 2 -- Number of spaces each tab counts for 
vim.opt.softtabstop = 2 -- Number of spaces for some tab operations
vim.opt.shiftwidth = 2 -- The space << and >> moves the lines 
vim.opt.expandtab = true -- Insert spaces instead of actual tabs
vim.opt.autoindent = true -- Indent the next line matching the previous line
vim.opt.shiftround = true -- Round << and >> to multiples of shiftwidth
vim.opt.smarttab = true -- Delete entire shiftwidth of tabs when they're inserted

vim.opt.hlsearch = true -- Highlight search terms
vim.opt.incsearch = true -- Show searches as you type

vim.opt.wrap = true -- Softwrap text
vim.opt.linebreak = true -- Don't wrap in the middle of words

vim.opt.termguicolors = true -- Better colors

-- Clean up netrw
vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25

-- Fold using treesitter
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Completions
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}

vim.cmd [[colorscheme nightfly]]
