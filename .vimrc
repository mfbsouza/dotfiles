" vimrc by mfbsouza based on 
" https://www.youtube.com/watch?v=XA2WjJbmmoM

" BASIC SETUP

" don't pretend to be vi
set nocompatible

" display horizontal menu for tab complete
set wildmenu

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
set autoindent

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

" AUTOCOMPLETE

" disable the preview window from onmi-complete 
set completeopt-=preview

" ^n for anything specified by the 'complete' option
" ^x^n for just this file
" ^x^f for filenames
" ^x^] for tags only
" ^x^o for tags like sctructs and methods
" and ^n and ^p will go back and forth in the suggestions

" FILE BROWSING

" tweaks for browsing
let g:netrw_banner=0        " disable banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_dirhistmax=0    " disable history
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'

" now i can :edit a folder to open file browser
" <CR>/v/t to open/v-split/tab

" HL TWEAKS
hi Pmenu ctermfg=white ctermbg=black
hi VertSplit ctermfg=black ctermbg=black
hi StatusLine ctermbg=white ctermfg=black
hi StatusLineNC ctermbg=white ctermfg=black

" LEADER KEY

" set the space bar as the leader key
nnoremap <SPACE> <Nop>
let mapleader=" "

" MAPS

" scroll up and down
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>

" open and close netrw
nnoremap <silent> <Leader>e :Lex 30<CR>

" clear highlight
nnoremap <silent> <Leader>h :noh<CR>

" quickly show buffer as wildmenu list after hitting tab
nnoremap <Tab> :b<space>

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
