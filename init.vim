call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'fatih/vim-go'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'majutsushi/tagbar'

Plug 'mileszs/ack.vim'
call plug#end()

let g:python_host_prog = '/usr/local/bin/python'
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

set exrc
set nohlsearch

let g:ycm_global_ycm_extra_conf = "~/.init/nvim/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

set autoread
" syntax highlightning
filetype plugin indent on
syntax on

" default to two space tab
" (place override in ftplugin file)
set tabstop=2
set shiftwidth=2
set expandtab

" bindings
let mapleader="\<SPACE>"
inoremap jk <Esc>
nnoremap <silent> <C-h> <C-w>h
nnoremap <silent> <C-j> <C-w>j
nnoremap <silent> <C-k> <C-w>k
nnoremap <silent> <C-l> <C-w>l
nmap <silent> <Leader>v <C-w>v
nmap <silent> <Leader>h <C-w>s
nnoremap <silent> <Leader>. :CtrlPTag<cr>
nnoremap <silent> <Leader>f :CtrlP<cr>
nnoremap <silent> <Leader>m :CtrlPMRU<cr>
nnoremap <silent> <Leader>b :CtrlPBuffer<cr>
nnoremap <silent> <Leader>t :TagbarToggle<cr>
nnoremap <Leader>a :Ack!<Space>
nnoremap <Leader>c :e %<.cc<Enter>
nnoremap <Leader>h :e %<.h<Enter>
tnoremap qp <C-\><C-n>

set cursorline
set showcmd
set showmatch
set showmode
set ruler
set number
set textwidth=0
set noswapfile

set noerrorbells
set modeline
" set esckeys
set linespace=0
set nojoinspaces

set splitbelow
set splitright

set background=dark

let g:ackprg='rg --no-heading --vimgrep'
