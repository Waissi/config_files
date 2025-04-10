"
"                                                 PLUGINS
"

call plug#begin()
Plug 'vim-python/python-syntax'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'mhinz/vim-startify'
Plug 'bfrg/vim-c-cpp-modern'
Plug 'euclidianAce/BetterLua.vim'
call plug#end()


"                                               
"                                               GLOBAL SETUP
"

filetype on
set path+=**
set tabstop=4
set laststatus=2
set statusline=%F
set shiftwidth=4
set expandtab
set autoindent
set wildmenu
set number
set viminfo="NONE"
set wildignore+=*.md
let g:netrw_winsize = 25
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let mapleader = "\<Space>"
let g:asyncomplete_auto_popup = 0
let g:startify_custom_header = []
let g:startify_enable_quote = 0
let g:python_highlight_all = 1
colorscheme slate 
highlight LineNr ctermfg=LightGrey
highlight Comment ctermfg=Lightgrey cterm=italic
"
"                                                  KEYMAPS
"

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

function! FindAndReplace()
    let old = expand('<cword>')
    let new = input("Replace " . old . " with: ")
    execute '%s/' . old . '/' . new . '/gc' 
endfunction
nnoremap <S-r> :call FindAndReplace()<cr>

inoremap <expr> <cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" 
"                                                 LSP SETUP
"

autocmd BufWritePre * call s:format_buffer()

function! s:format_buffer() abort
    if &modifiable && &filetype != ''
        LspDocumentFormatSync
    endif
endfunction

if executable('lua-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'lua-language-server',
        \ 'cmd': {server_info->['lua-language-server']},
        \ 'allowlist': ['lua'],
        \ })
endif

if executable('pylsp')
    " pip install python-lsp-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pylsp',
        \ 'cmd': {server_info->['pylsp']},
        \ 'allowlist': ['python'],
        \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd']},
        \ 'allowlist': ['c'],
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
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup ENDsyntax on
