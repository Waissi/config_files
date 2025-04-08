syntax on
filetype on
let mapleader = "\<Space>"
nnoremap <leader>w :bdelete<cr>
nnoremap <leader>e :Lexplore<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>p :find 
nnoremap <leader>f :execute 'find ' . expand('<cword>') . '.' . &filetype<cr>
nnoremap <leader>F :execute 'vimgrep ' . '/' . expand('<cword>') . '/' '**/*.' . &filetype<cr>  
nnoremap <leader>S :Startify<cr>
nnoremap <S-l> :bnext<cr>
nnoremap <S-h> :bprevious<cr>
nnoremap <S-j> <C-f><cr>
nnoremap <S-k> <C-b><cr>
nnoremap <Up> :cprevious<cr>
nnoremap <Down> :cnext<cr>
nnoremap <F6> :!scripts/run.sh<cr>
set path+=**
set title
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
Plug 'euclidianAce/BetterLua.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'mhinz/vim-startify'
Plug 'bfrg/vim-c-cpp-modern'
call plug#end()
colorscheme one

function! FindAndReplace()
    let old = expand('<cword>')
    let new = input("Replace " . old . " with: ")
    execute '%s/' . old . '/' . new . '/gc' 
endfunction
nnoremap <S-r> :call FindAndReplace()<cr>
