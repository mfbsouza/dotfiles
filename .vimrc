" my personal vimrc file by github.com/mfbsouza

" encoding
set encoding=utf-8
set fileencoding=utf-8

" use tab instead of spaces and tab size
set tabstop=4 shiftwidth=4 noexpandtab
filetype indent on

" visual
syntax enable
set number
set wildmenu
set is hls

" use ctrl + up and down arrows to move page up/down by half
nnoremap <C-Up>    <C-u>
nnoremap <C-Down>  <C-d>

" command to show changes since the last save
command Changes :w !diff % -
" command to clear hightlighted matches
command Clear :noh

" use alt + arrows keys to move between windows
nnoremap <M-Left>  <C-w>h
nnoremap <M-Right> <C-w>l
nnoremap <M-Up>    <C-w>k
nnoremap <M-Down>  <C-w>j

" use alt + (h,j,k,l) to resize windows
nnoremap <M-h> :vertical resize -2<CR>
nnoremap <M-l> :vertical resize +2<CR>
nnoremap <M-k> :resize -2<CR>
nnoremap <M-k> :resize +2<CR>

