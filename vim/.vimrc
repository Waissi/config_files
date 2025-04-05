syntax on
let mapleader = "\<Space>"
nnoremap <S-l> :bnext<cr>
nnoremap <S-h> :bprevious<cr>
nnoremap <leader>w :bdelete<cr>
nnoremap <leader>e :Explore<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>q :q<cr>
set path+=**
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set wildmenu
set number
set viminfo="NONE"
set wildignore+=*.md
call plug#begin()
Plug 'rafi/awesome-vim-colorschemes'
Plug 'euclidianAce/BetterLua.vim'
Plug 'mhinz/vim-startify'
call plug#end()
colorscheme one
