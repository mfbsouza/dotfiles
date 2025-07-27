" faster faster
set updatetime=50

" disable status line
set laststatus=0

" enable syntax highlighting
syntax on

" highlight search and incremental search
set hlsearch
set incsearch

" ignore case in search
set ignorecase

" allow switching buffers without saving
set hidden

" minimum lines to keep above and below the cursor
set scrolloff=1

" disable swap files
set noswapfile

" show line numbers
set number

" enable mouse support
set mouse=a

" autoreload files changed outside vim
set autoread

" split directions
set splitright
set splitbelow

" use system clipboard
set clipboard=unnamedplus

" tab and indentation settings
set shiftwidth=4
set tabstop=4

" completion menu behavior
set completeopt=menuone,noselect,noinsert

" popup menu height
set pumheight=10

" MAP OPTIONS

" Use space as leader key
nnoremap <Space> <Nop>
let mapleader = " "
let maplocalleader = " "

" Scroll up and down with keyboard
nnoremap <C-Up> <C-y>
nnoremap <C-Down> <C-e>

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

" Move text sideways and keep selection
vnoremap < <gv
vnoremap > >gv

" Move text up/down (Alt + , / Alt + .)
vnoremap <A-,> :m '>+1<CR>gv=gv
vnoremap <A-.> :m '<-2<CR>gv=gv

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
