" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clangd-completer' }
call plug#end()

" ycm
set signcolumn=no
" <plug>(YCMHover) to trigger
let g:ycm_auto_hover = 0
let g:ycm_show_diagnostics_ui = 0
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_min_num_of_chars_for_completion = 10
