" vimrc by mfbsouza based on 
" https://www.youtube.com/watch?v=XA2WjJbmmoM

" BASIC SETUP

" don't pretend to be vi
set nocompatible

" faster faster
set updatetime=100

" dark background color
set background=dark

" display horizontal menu for tab complete
set wildmenu

" dont show status line
set laststatus=0

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

" enable syntax and plugins
filetype plugin indent on

" indent
set ai si

" FINDING FILES

" search down into subfolders
" provides tab-completion for all file-related tasks
set path+=**

" now i can hit tab to :find by partial match
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

" navigate through buffers
nnoremap <silent> <C-Right> :bnext<CR>
nnoremap <silent> <C-Left> :bprev<CR>

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

"double click to highlight all occurrences
nnoremap <silent> <2-LeftMouse> :let @/='\V\<'.escape(expand('<cword>'), '\').'\>'<cr>:set hls<cr>

" PLUGINS

" Install vim-plug if not installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" init plugins
call plug#begin()
  Plug 'ackyshake/VimCompletesMe'
  Plug 'airblade/vim-gitgutter'
  Plug 'jiangmiao/auto-pairs'
  Plug 'preservim/nerdtree'
  Plug 'ap/vim-buftabline'
  Plug 'mfbsouza/preto'
call plug#end()

" GUI Configs
if has("gui_running")
	" colors
	set termguicolors
	syntax on
	color preto
	" hide menu bar, tool bar and left scroll bar
	set guioptions-=m
	set guioptions-=T
	set guioptions-=L
	" always show sign column
	set signcolumn=yes
	" font
	set guifont=Inconsolata\ Medium\ 14
endif

" HL TWEAKS

hi SignColumn guibg=NONE ctermbg=NONE
hi VertSplit  guibg=NONE ctermbg=NONE
hi GitGutterAdd          ctermbg=235
hi GitGutterChange       ctermbg=235
hi GitGutterDelete       ctermbg=235
hi GitGutterChangeDelete ctermbg=235

"  PLUGINS CONFIG

" VIM-BUFTABLINE

let g:buftabline_show=1

" NERDTREE

let g:NERDTreeMinimalUI=1
let g:NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.cache$']
nnoremap <silent> <Leader>e :NERDTreeToggle<CR>

" auto close nerdtree is closing the last buffer
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" hide cwd in nerdtree
augroup nerdtreehidecwd
  autocmd!
  autocmd FileType nerdtree setlocal conceallevel=3
          \ | syntax match NERDTreeHideCWD #^[</].*$# conceal
          \ | setlocal concealcursor=n
augroup end
