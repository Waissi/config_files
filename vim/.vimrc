"
"                                                 PLUGINS
"

call plug#begin()
Plug 'mhinz/vim-startify'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'bfrg/vim-c-cpp-modern'
Plug 'vim-python/python-syntax'
Plug 'euclidianAce/BetterLua.vim'
Plug 'preservim/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'rafi/awesome-vim-colorschemes'
call plug#end()


"                                               
"                                               GLOBAL SETUP
"

filetype on
syntax on
set expandtab
set autoindent
set smartindent 
set wildmenu
set number
set path+=**
set tabstop=4
set laststatus=2
set statusline=%F
set shiftwidth=4
set viminfo="NONE"
set wildignore+=*.md

let mapleader = "\<Space>"
let g:asyncomplete_auto_popup = 0
let g:startify_custom_header = []
let g:startify_enable_quote = 0
let g:python_highlight_all = 1
let NERDTreeShowHidden=1
let g:NERDTreeIgnore = ['\.DS_Store$']

colorscheme minimalist 
highlight Normal ctermbg=NONE
highlight NonText ctermbg=NONE
highlight NormalNC ctermbg=NONE
highlight StatusLine ctermbg=NONE
highlight EndOfBuffer ctermbg=NONE
highlight SignColumn ctermbg=NONE
highlight LineNr ctermfg=Grey ctermbg=NONE
highlight Comment ctermfg=Lightgrey cterm=italic
highlight NERDTreeDir ctermfg=LightMagenta
highlight NERDTreeFile ctermfg=LightGrey
highlight Visual ctermbg=Grey
"
"                                                  KEYMAPS
"

nnoremap <leader>w :bdelete<cr>
nnoremap <leader>e :NERDTreeToggle<cr>
nnoremap <leader>s :w<cr>
nnoremap <leader>q :q<cr>
nnoremap <leader>p :find 
nnoremap <leader>t :terminal<cr>
nnoremap <leader>f :execute 'find ' . expand('<cword>') . '.' . expand("%:e")<cr>
nnoremap <leader>F :call GlobalSearch(expand('<cword>'))<cr>
nnoremap <leader>S :Startify<cr>
nnoremap <S-l> :bnext<cr>
nnoremap <S-h> :bprevious<cr>
nnoremap <S-j> <C-f><cr>
nnoremap <S-k> <C-b><cr>
nnoremap <Up> :cprevious<cr>
nnoremap <Down> :cnext<cr>
nnoremap <F6> :!scripts/run.sh<cr>

function! GlobalSearch(word='')
    if a:word == ''
        let word = input("Type word to search:")
    else
        let word = a:word
    endif
    let extension = "--include='*." . expand("%:e") . "'"
    execute 'grep ' . word . ' . ' . '-w -r ' . extension
endfunction
nnoremap <c-f> :call GlobalSearch()<cr>

function! FindAndReplace()
    let old = expand('<cword>')
    let new = input("Replace " . old . " with: ")
    execute '%s/' . old . '/' . new . '/gc' 
endfunction
nnoremap <S-r> :call FindAndReplace()<cr>

function! SetBreakpoint()
    let text = ''
    let type = &filetype
    if type ==# 'python'
        let text = 'breakpoint()'
    elseif type ==# 'lua'
        let text = 'dbg()'
    endif
    let indt = indent(line('.'))
    call append(line('.') - 1, repeat(' ', indt) . text)
endfunction
nnoremap <leader>b :call SetBreakpoint()<cr>

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


function! s:format_buffer() abort
    if &modifiable && &filetype != ''
        LspDocumentFormatSync
    endif
endfunction
autocmd BufWritePre * call s:format_buffer()

if executable('lua-language-server')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'lua-language-server',
        \ 'cmd': {server_info->['lua-language-server']},
        \ 'allowlist': ['lua'],
        \ })
endif

if executable('pylsp')
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
    nnoremap <buffer> <expr><c-j> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-k> lsp#scroll(-4)
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup ENDsyntax on
