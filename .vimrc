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

" use tab instead of spaces and tab size
set tabstop=8 shiftwidth=8 noexpandtab
filetype indent on

" incremental search and hl
set is hls

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

" use ctrl+f to search
map <C-F> /
