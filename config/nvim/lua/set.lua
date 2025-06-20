vim.opt.history = 1000        -- The number of history items to remember
vim.opt.startofline = false   -- Keep cursor in same place after saves
vim.opt.nu = true
vim.opt.relativenumber = true -- Use relative line numbers for easy jumping

vim.opt.tabstop = 2           -- Number of spaces each tab counts for
vim.opt.softtabstop = 2       -- Number of spaces for some tab operations
vim.opt.shiftwidth = 2        -- The space << and >> moves the lines
vim.opt.expandtab = true      -- Insert spaces instead of actual tabs
vim.opt.autoindent = true     -- Indent the next line matching the previous line
vim.opt.shiftround = true     -- Round << and >> to multiples of shiftwidth
vim.opt.smarttab = true       -- Delete entire shiftwidth of tabs when they're inserted

vim.opt.hlsearch = true       -- Highlight search terms
vim.opt.incsearch = true      -- Show searches as you type

vim.opt.wrap = true           -- Softwrap text
vim.opt.linebreak = true      -- Don't wrap in the middle of words

vim.opt.termguicolors = true  -- Better colors
vim.opt.autoread = true       -- Watch for file changes and auto updates
vim.opt.showmatch = true      -- Set show match parenthesis
vim.opt.errorbells = false    -- Don't make noise

vim.opt.gdefault = true       -- Adds g at the end of substitutions by default
vim.opt.ignorecase = true     -- Ignore case when searching
vim.opt.smartcase = true      -- Ignore case if search is lowercase, otherwise case-sensistive
vim.opt.title = true          -- Change the terminal's title
vim.opt.showcmd = true        -- Show command information on the right side of the command line

vim.opt.exrc = true           -- Source local .vimrc files
vim.opt.secure = true         -- Don't load autocmds from local .vimrc files

vim.opt.cursorline = true     -- Highlight the current line

vim.opt.signcolumn = 'yes'

-- Fold using treesitter
vim.opt.foldenable = false -- Prevents folding on save
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

-- Completions
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)

vim.cmd [[colorscheme kanso-zen]]

vim.cmd [[ filetype plugin on ]]

-- Show special characters
vim.opt.listchars = {
  trail = '~',
  tab = '>-',
  nbsp = '␣'
}
vim.opt.list = true

-- Mark the trailing whitespace marker red
vim.fn.matchadd('ErrorMsg', [[\s\+$]])

vim.cmd [[
  highlight Normal guibg=none
  highlight NonText guibg=none
  highlight Normal ctermbg=none
  highlight NonText ctermbg=none
]]

