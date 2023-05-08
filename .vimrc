" vimrc by mfbsouza based on 
" https://www.youtube.com/watch?v=XA2WjJbmmoM

" BASIC SETUP
" don't pretend to be vi
set nocompatible

" faster faster
set updatetime=50

" disable status line
set laststatus=0

" hl search and go to match while typing
set is hls

" ignore word case in search mode
set ignorecase

" navigate through buffer freely
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

" autoindent and smartindent
set ai
set si

" always show signcolumn
"set signcolumn=yes

" always show tabline
"set showtabline=2

" vsplit to the right and split always below
"set splitright=yes
"set splitbelow=yes

" display horizontal menu for tab complete
set wildmenu

" VIM'S BUILDIN AUTOCOMPLETE
" disable the preview window from onmi-complete 
"set completeopt-=preview
set completeopt=menuone
set completeopt+=noselect
set completeopt+=noinsert
" ^n for anything specified by the 'complete' option
" ^x^n for just this file
" ^x^f for filenames
" ^x^] for tags only
" ^x^o for omnicomplete
" and ^n and ^p will go back and forth in the suggestions

set shiftwidth=4
set tabstop=4

" enable syntax and plugins
filetype plugin indent on

" FINDING FILES
" search down into subfolders
" provides tab-completion for all file-related tasks
set path+=**
" now i can hit tab to :find by partial match
" and use * to make it fuzzy

" TAG JUMPING
" i can ^] to jump to the tag under the cursor
" and ^t to jump back
" also g^] for ambiguous tags

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

" navigate through windows
nnoremap <silent> <A-Right> :wincmd l<CR>
nnoremap <silent> <A-Left> :wincmd h<CR>
nnoremap <silent> <A-Up> :wincmd k<CR>
nnoremap <silent> <A-Down> :wincmd j<CR>

" open file explorer on the left
nnoremap <silent> <Leader>e :Lex 30<CR>

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
