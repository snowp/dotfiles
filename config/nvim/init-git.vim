call plug#begin()

Plug 'bluz71/vim-nightfly-guicolors'
call plug#end()

" nightly requires termguicolors
set termguicolors
set background=dark
colorscheme nightfly

let g:mapleader="\<Space>"

nnoremap Q :quit<CR>

" Easier save mapping
nnoremap W :write<CR>

" " Copy to clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
nnoremap  <leader>yy  "+yy

" " Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Leave insert mode with jj
inoremap jk <Esc>
