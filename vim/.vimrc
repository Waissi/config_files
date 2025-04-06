syntax on
let mapleader = "\<Space>"
nnoremap <leader>w :bdelete<cr>
nnoremap <leader>e :Explore<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <S-l> :bnext<cr>
nnoremap <S-h> :bprevious<cr>
nnoremap <S-j> <C-f><cr>
nnoremap <S-k> <C-b><cr>
nnoremap <leader>p :find 
nnoremap <F6> :!scripts/run.sh<cr>
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

function! GitCommit()
    let message =  input('Commit message: ')
    execute '!git_commit' message
endfunction
nnoremap <F7> :call GitCommit() <cr>

