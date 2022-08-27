" vimrc by mfbsouza based on 
" https://www.youtube.com/watch?v=XA2WjJbmmoM

" BASIC SETUP

" don't pretend to be vi
set nocompatible

" faster faster
set updatetime=300

" colors
set termguicolors
set background=dark

" display horizontal menu for tab complete
set wildmenu

" always show sign column
set signcolumn=yes

" go to match while type in search mode
set is hls

" navigate through buffers without need for save
set hidden

" scroll the file when hitting the frame limits
set scrolloff=5

" disable swap file
set noswapfile

" enable line number
set number

" enable mouse scroll and visual selection
set mouse=a

" auto reload file if there was a change in disk
set autoread

" enable syntax and plugins (for netrw)
syntax on
filetype plugin indent on

" indent
set ai si

" FINDING FILES

" search down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

" now i can hit tab to :find bt partial match
" and use * to make it fuzzy

" TAG JUMPING
command! MakeTags !ctags -R .

" now i can ^] to jump to the tag under the cursor
" and ^t to jump back
" also g^] for ambiguous tags

" VIM'S BUILDIN AUTOCOMPLETE

" disable the preview window from onmi-complete 
set completeopt-=preview

" ^n for anything specified by the 'complete' option
" ^x^n for just this file
" ^x^f for filenames
" ^x^] for tags only
" ^x^o for omnicomplete
" and ^n and ^p will go back and forth in the suggestions

" FILE BROWSING

" LEADER KEY

" set the space bar as the leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" MAPS

" scroll up and down
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>

" clear highlight
nnoremap <silent> <Leader>h :noh<CR>

" navigate buffers
nnoremap <silent> <S-Tab> :bnext<CR>

" close buffer
nnoremap <silent> <Leader>d :bd<CR>

" stay in indent mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" don't save to register when paste in top of something
vnoremap p "_dP

" system clipboard
inoremap <C-v> <ESC>"+pa
vnoremap <C-v> "+pa
vnoremap <C-c> "+y

" PLUGINS

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

call plug#begin()
  Plug 'Valloric/YouCompleteMe', { 'do': 'python3 install.py --clangd-completer --rust-completer' }
  Plug 'airblade/vim-gitgutter'
  Plug 'preservim/nerdtree'
  Plug 'morhetz/gruvbox'
call plug#end()

" COLORSCHEME
colorscheme gruvbox

" HL TWEAKS
hi Normal guibg=NONE ctermbg=NONE
hi SignColumn guibg=NONE ctermbg=NONE
hi VertSplit guibg=NONE ctermbg=NONE

" YCM CONFIG
" <plug>(YCMHover) to trigger
let g:ycm_auto_hover=''
let g:ycm_min_num_of_chars_for_completion=10

" NERDTREE
let g:NERDTreeMinimalUI=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>
