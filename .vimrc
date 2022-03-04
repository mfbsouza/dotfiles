" Vundle Config
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

" YCM config
let g:ycm_show_diagnostics_ui = 0
let g:ycm_min_num_of_chars_for_completion = 10
set completeopt-=preview

" Popup menu color config
highlight Pmenu ctermfg=white ctermbg=black
highlight PmenuSel ctermfg=darkgrey ctermbg=black
