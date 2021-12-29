" my personal vimrc file by github.com/mfbsouza

" encoding
set fileencodings=utf-8
set encoding=utf-8

" use tab instead of spaces and tab size
set tabstop=4 shiftwidth=4 noexpandtab
filetype indent on

" visual
set hidden
syntax enable
set number
set wildmenu
set is hls

" command to convert tabs to 4 spaces
command ConvertToSpaces set tabstop=4 shiftwidth=4 expandtab | retab | w

" command to convert 4 spaces to tabs
command ConvertToTabs set tabstop=4 shiftwidth=4 noexpandtab | %retab! | w

" command to show changes since the last save
command Changes :w !diff % -

