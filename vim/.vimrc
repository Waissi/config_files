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
Plug 'mhinz/vim-startify'
Plug 'bfrg/vim-c-cpp-modern'
Plug 'prabirshrestha/vim-lsp'
call plug#end()
colorscheme slate 
highlight LineNr ctermfg=LightGrey

function! FindAndReplace()
    let old = expand('<cword>')
    let new = input("Replace " . old . " with: ")
    execute '%s/' . old . '/' . new . '/gc' 
endfunction
nnoremap <S-r> :call FindAndReplace()<cr>

if executable('lua-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'lua-language-server',
        \ 'cmd': {server_info->['lua-language-server']},
        \ 'allowlist': ['lua'],
        \ })
endif

if executable('terraform-ls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'terraform-ls',
        \ 'cmd': {server_info->['terraform-ls', 'serve']},
        \ 'allowlist': ['terraform'],
        \ })
endif

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> <leader>k <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')

    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END
