vim.cmd("syntax on")
vim.cmd("filetype on")
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<leader>w", ":bdelete<CR>", opts)
map("n", "<leader>e", ":Lexplore<CR>", opts)
map("n", "<leader>s", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>p", ":find ", opts)
map("n", "<leader>f", [[:execute 'find ' .. expand('<cword>') .. '.' .. &filetype<CR>]], {})
map("n", "<leader>F", [[:execute 'vimgrep /' .. expand('<cword>') .. '/' '**/*.' .. &filetype<CR>]], {})
map("n", "<leader>S", ":Startify<CR>", opts)
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<S-j>", "<C-f><CR>", opts)
map("n", "<S-k>", "<C-b><CR>", opts)
map("n", "<Up>", ":cprevious<CR>", opts)
map("n", "<Down>", ":cnext<CR>", opts)
map("n", "<F6>", ":!scripts/run.sh<CR>", opts)
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { noremap = true, silent = true })

vim.opt.path:append("**")
vim.opt.title = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wildmenu = true
vim.opt.number = true
vim.opt.wildignore:append("*.md")
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

vim.cmd([[
call plug#begin('~/.vim/plugged')
Plug 'rakr/vim-one'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
call plug#end()
]])
vim.cmd("colorscheme one")
vim.g.startify_lists = {
  { type = 'sessions', header = {'   Saved Sessions'} },
}

require'lspconfig'.lua_ls.setup {
  on_init = function(client)
      client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        version = 'LuaJIT'
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/love2d/library"
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
}
