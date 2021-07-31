" encoding
set encoding=utf-8
set fileencoding=utf-8

" visual
syntax enable
set number
set wildmenu
set background=dark

" pratical
set mouse=a
set tabstop=4 shiftwidth=4 expandtab
filetype indent on
set hlsearch

set noswapfile

" use alt + arrow keys to resize windows
nnoremap <M-Left>  :vertical resize -2<CR>
nnoremap <M-Right> :vertical resize +2<CR>
nnoremap <M-Up>    :resize -2<CR>
nnoremap <M-Down>  :resize +2<CR>

" window navegation
nnoremap <C-Left>  <C-w>h
nnoremap <C-Right> <C-w>l
nnoremap <C-Up>    <C-w>k
nnoremap <C-Down>  <C-w>j

" use ctrl+s to save
nnoremap <C-s> :w<CR>
" use ctrl+w to exit
nnoremap <C-w> :q<CR>

