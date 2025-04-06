syntax on
let mapleader = "\<Space>"
nnoremap <leader>w :bdelete<cr>
nnoremap <leader>e :Lexplore<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>p :find 
nnoremap <S-l> :bnext<cr>
nnoremap <S-h> :bprevious<cr>
nnoremap <S-j> <C-f><c>
nnoremap <S-k> <C-b><cr>
nnoremap <F6> :!scripts/run.sh<cr>
nnoremap <F7> :!git_commit <cr>
set path+=**
set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set wildmenu
set number
set viminfo="NONE"
set wildignore+=*.md
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
"let g:netrw_keepdir = 0
let g:netrw_banner = 0
call plug#begin()
Plug 'rafi/awesome-vim-colorschemes'
Plug 'euclidianAce/BetterLua.vim'
Plug 'mhinz/vim-startify'
call plug#end()
colorscheme one
