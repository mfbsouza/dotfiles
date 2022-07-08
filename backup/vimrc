" OPTIONS

set nocompatible
set nobackup
set noswapfile
set nowritebackup
set hidden
set wildmenu
set termguicolors
set scrolloff=8
set laststatus=0
set encoding=utf-8
set is hls

" KEYBINDS

" space as leader key
nnoremap <silent> <SPACE> <Nop>
let mapleader=" "

" resize
nnoremap <silent> <C-Up> :resize +2<CR>
nnoremap <silent> <C-Down> :resize -2<CR>
nnoremap <silent> <C-Left> :vertical resize +2<CR>
nnoremap <silent> <C-Right> :vertical resize -2<CR>

" navigate buffers
nnoremap <silent> <S-Right> :bnext<CR>
nnoremap <silent> <S-Left> :bprevious<CR>

" quickly exit insert mode
inoremap <silent> jk <ESC>

" stay in indent mode
vnoremap <silent> < <gv
vnoremap <silent> > >gv

" explorer
nnoremap <silent> <leader>e :NERDTreeToggle<CR>

" close buffer
nnoremap <silent> <leader>c :bd<CR>

" PLUGINS
 
" vundle
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
	Plugin 'VundleVim/Vundle.vim'
	Plugin 'Valloric/YouCompleteMe'
	Plugin 'ap/vim-buftabline'
	Plugin 'preservim/nerdtree'
	Plugin 'TheNiteCoder/mountaineer.vim'
call vundle#end()

filetype plugin indent on

" colorscheme
colorscheme mountaineer

" ycm
let g:ycm_show_diagnostics_ui = 0
let g:ycm_min_num_of_chars_for_completion = 10
set completeopt-=preview

" buftabline
let g:buftabline_show = 1
