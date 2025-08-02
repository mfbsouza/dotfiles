" Minimal plugins

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

set nocompatible
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'sheerun/vim-polyglot'
Plug 'joshdick/onedark.vim'
call plug#end()

" Colorscheme

set termguicolors
colorscheme onedark
if !has("gui_running")
  autocmd ColorScheme * highlight! Normal ctermbg=NONE guibg=NONE
  autocmd ColorScheme * highlight! EndOfBuffer ctermbg=NONE guibg=NONE
endif
set fillchars-=vert:\|
set fillchars+=vert:\ 
autocmd ColorScheme * highlight VertSplit guibg=#333333

" Basic configs

syntax on
let g:netrw_banner = 0
set updatetime=300
set laststatus=0
set hlsearch
set incsearch
set ignorecase
set hidden
set scrolloff=2
set noswapfile
set number
set mouse=a
set autoread
set splitright
set splitbelow
set noexpandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set pumheight=10
set completeopt=menuone,noselect,noinsert

" Keybinds

" Use space as leader key
nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = " "

" Keep cursor in the middle when jumping half pages
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Keep cursor in the middle when jumping between search results
nnoremap n nzzzv
nnoremap N Nzzzv

" Clear search highlight
nnoremap <Leader>h :noh<CR>

" Open netrw tree view on the left
nnoremap <Leader>e :Lex 30<CR>

" Move text
vnoremap <S-Right> >gv
vnoremap <S-Left> <gv
vnoremap <S-Up> :m '<-2<CR>gv=gv
vnoremap <S-Down> :m '>+1<CR>gv=gv

" Comment block of lines
vnoremap gc :<C-u>'<,'>norm i

" Avoid yanking when replacing or deleting
vnoremap p "_dP
nnoremap S "_S
nnoremap x "_x
nnoremap c "_c
nnoremap D "_D
nnoremap C "_C

" System clipboard paste and copy
inoremap <C-v> <Esc>"+pa
vnoremap <C-v> "+pa
vnoremap <C-c> "+y

" Double click to search and highlight all
nnoremap <2-LeftMouse> *N

" use tab in the popup menu item selection
inoremap <expr> <Tab>     pumvisible() ? "\<Down>" : "\<Tab>"
inoremap <expr> <S-Tab>   pumvisible() ? "\<Up>"   : "\<S-Tab>"

" fzf and ripgrep
nnoremap <silent> ff :Files!<CR>
nnoremap <silent> fb :Buffers!<CR>
nnoremap <silent> fg :Rg!<CR>

