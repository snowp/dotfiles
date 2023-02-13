lua require('remap')
lua require('pack')

call plug#begin()
" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

" Make sure you use single quotes

Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'nvim-lua/lsp-status.nvim'
Plug 'doums/lsp_spinner.nvim'
Plug 'airblade/vim-gitgutter'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

Plug 'nvim-lua/plenary.nvim'

" LSP and autocomplete.
Plug 'neovim/nvim-lspconfig'
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'jjo/vim-cue'
Plug 'ray-x/go.nvim'
Plug 'ray-x/guihua.lua'
Plug 'fatih/vim-go'
Plug 'ray-x/lsp_signature.nvim'
Plug 'mfussenegger/nvim-dap'

" VCS
Plug 'tpope/vim-fugitive'

" Language plugins
Plug 'simrat39/rust-tools.nvim'
Plug 'udalov/kotlin-vim'
Plug 'hashivim/vim-terraform'
Plug 'jjo/vim-cue'

Plug 'mtdl9/vim-log-highlighting'
Plug 'frazrepo/vim-rainbow'
Plug 'sbdchd/neoformat'

" Color scheme.
Plug 'bluz71/vim-nightfly-guicolors'

" Initialize plugin system
call plug#end()

syntax enable
filetype plugin indent on

if executable('~/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer')
  au User lsp_setup call lsp#register_server({
        \   'name': 'Rust Language Server',
        \   'cmd': {server_info->['~/.rustup/toolchains/nightly-aarch64-apple-darwin/bin/rust-analyzer']},
        \   'whitelist': ['rust'],
        \ })
endif



if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit-lsp',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

autocmd FileType swift setlocal omnifunc=lsp#complete


" nightly requires termguicolors
set termguicolors
set background=dark
colorscheme nightfly

" Run formatter on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

set shell=$SHELL               " Set the default shell
set termencoding=utf-8         " Set the default encodings just in case $LANG isn't set
set encoding=utf-8             " Set the default encodings just in case $LANG isn't set
set autoindent                 " Indent the next line matching the previous line
set smartindent                " Smart auto-indent when creating a new line
set tabstop=2                  " Number of spaces each tab counts for
set shiftwidth=2               " The space << and >> moves the lines
set softtabstop=2              " Number of spaces for some tab operations
set shiftround                 " Round << and >> to multiples of shiftwidth
set expandtab                  " Insert spaces instead of actual tabs
set smarttab                   " Delete entire shiftwidth of tabs when they're inserted
set history=1000               " The number of history items to remember
set backspace=indent,eol,start " Backspace settings
set nostartofline              " Keep cursor in the same place after saves
set showcmd                    " Show command information on the right side of the command line
set isfname-==                 " Remove characters from filenames for gf

" Create a directory if it doesn't exist yet
function! s:EnsureDirectory(directory)
  if !isdirectory(expand(a:directory))
    call mkdir(expand(a:directory), 'p')
  endif
endfunction

" Save backup files, storage is cheap, losing changes is sad
set backup
set backupdir=$HOME/.tmp/vim/backup
call s:EnsureDirectory(&backupdir)

set ttyfast                 " Set that we have a fast terminal
set t_Co=256                " Explicitly tell Vim that the terminal supports 256 colors
set lazyredraw              " Don't redraw vim in all situations
set synmaxcol=500           " The max number of columns to try and highlight
set noerrorbells            " Don't make noise
set autoread                " Watch for file changes and auto update
set showmatch               " Set show matching parenthesis
set matchtime=2             " The amount of time matches flash
set display=lastline        " Display super long wrapped lines
set number                  " Shows line numbers
set nrformats-=octal        " Never use octal notation
set nojoinspaces            " Don't add 2 spaces when using J
set mouse=a                 " Enable using the mouse if terminal emulator
set mousehide               " Hide the mouse on typing
set hlsearch                " Highlight search terms
set incsearch               " Show searches as you type
set wrap                    " Softwrap text
set linebreak               " Don't wrap in the middle of words
set ignorecase              " Ignore case when searching
set smartcase               " Ignore case if search is lowercase, otherwise case-sensitive
set title                   " Change the terminal's title
set updatetime=2000         " Set the time before plugins assume you're not typing
set scrolloff=5             " Lines the cursor is to the edge before scrolling
set sidescrolloff=5         " Same as scrolloff but horizontal
set gdefault                " Adds g at the end of substitutions by default
set virtualedit=block       " Allow the cursor to move off the side in visual block
set nofoldenable
set foldmethod=indent       " Decide where to fold based
set foldnestmax=5           " Set deepest fold to x levels
set exrc                    " Source local .vimrc files
set secure                  " Don't load autocmds from local .vimrc files
set tags^=.tags,.git/tags   " Add local .tags file
set signcolumn=yes

" Completion options
set complete=.,w,b,u,t,kspell
set wildmenu                                           " Better completion in the CLI
set wildmode=longest:full,full                         " Completion settings

" ?? what are these for
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Ignore these folders for completions
set wildignore+=.hg,.git,.svn                          " Version control
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg         " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc " compiled object files
set wildignore+=*.resolved                             " package manager lock files
set wildignore+=tags,.tags

lua require('setup')

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.resolve_timeout = 800
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true
let g:compe.source.ultisnips = v:true
let g:compe.source.luasnip = v:true
let g:compe.source.emoji = v:true

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
  autocmd FileType swift AutoFormatBuffer swiftformat
augroup END

" Enable rainbow brackets
au FileType c,cpp,objc,objcpp,rust,bzl call rainbow#load()


" Functions for status line config since these functions aren't loaded
" when the vimrc is sourced
function! CurrentTag(...)
  if exists('g:tagbar_iconchars')
    return call('tagbar#currenttag', a:000)
  else
    return ''
  endif
endfunction

function! LspStatus()
  if has('nvim')
    return luaeval("require'lsp_spinner'.status(bufnr)")
  else
    return ''
  endif
endfunction

" Status line setup (without plugins)
set laststatus=2 " Always show the statusline
" Left Side
set statusline=%{LspStatus()}
set statusline+=%#IncSearch#%{&paste?'\ \ PASTE\ ':''}%*
set statusline+=\ %.50f
set statusline+=\ %m
set statusline+=\ %r
set statusline+=%=
" Right Side
" TODO: use treesitter here first if enabled? nvim_treesitter#statusline
set statusline+=%{CurrentTag('%s\ <\ ','','')}
set statusline+=%y
set statusline+=\ \ %P
set statusline+=-%l
set statusline+=-%c
set statusline+=\ %{LspStatus()}

" Set up debugger
packadd termdebug
let termdebugger=["rust-lldb"]
  
autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()

lua require('go').setup()

