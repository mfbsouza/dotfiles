" vim config
set nocompatible
set hidden
set wildmenu		" show prettier menu completions
set scrolloff=5		" line margin when scrolling up or down
set is hls		" incremental search and highlight

" vundle Config (plugin manager)
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
call vundle#end()
filetype plugin indent on

" ycm config (intellisense like)
let g:ycm_show_diagnostics_ui = 0
let g:ycm_min_num_of_chars_for_completion = 10
set completeopt-=preview
highlight Pmenu ctermfg=white ctermbg=black
highlight PmenuSel ctermfg=darkgrey ctermbg=black
