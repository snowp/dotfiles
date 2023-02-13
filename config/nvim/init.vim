if executable('sourcekit-lsp')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'sourcekit',
        \ 'cmd': {server_info->['sourcekit-lsp']},
        \ 'whitelist': ['swift'],
        \ })
endif

lua require('remap')
lua require('pack')
lua require('set')

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
Plug 'airblade/vim-gitgutter'

Plug 'mtdl9/vim-log-highlighting'
Plug 'frazrepo/vim-rainbow'
Plug 'sbdchd/neoformat'

" Initialize plugin system
call plug#end()

autocmd FileType swift setlocal omnifunc=lsp#complete

" Run formatter on save
" augroup fmt
"   autocmd!
"   autocmd BufWritePre * undojoin | Neoformat
" augroup END

set shell=$SHELL               " Set the default shell
set termencoding=utf-8         " Set the default encodings just in case $LANG isn't set
set encoding=utf-8             " Set the default encodings just in case $LANG isn't set
set history=1000               " The number of history items to remember
set backspace=indent,eol,start " Backspace settings
set nostartofline              " Keep cursor in the same place after saves
set showcmd                    " Show command information on the right side of the command line
set isfname-==                 " Remove characters from filenames for gf
set ttyfast                 " Set that we have a fast terminal
set t_Co=256                " Explicitly tell Vim that the terminal supports 256 colors
set lazyredraw              " Don't redraw vim in all situations
set synmaxcol=500           " The max number of columns to try and highlight
set noerrorbells            " Don't make noise
set autoread                " Watch for file changes and auto update
set showmatch               " Set show matching parenthesis
set matchtime=2             " The amount of time matches flash
set display=lastline        " Display super long wrapped lines
set nrformats-=octal        " Never use octal notation
set nojoinspaces            " Don't add 2 spaces when using J
set mouse=a                 " Enable using the mouse if terminal emulator
set mousehide               " Hide the mouse on typing
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

" Status line setup (without plugins)
set laststatus=2 " Always show the statusline
" Left Side
" set statusline=%{LspStatus()}
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
" set statusline+=\ %{LspStatus()}

autocmd BufWritePre *.go :silent! lua require('go.format').gofmt()
