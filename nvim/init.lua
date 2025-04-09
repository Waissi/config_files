vim.cmd("syntax on")
vim.cmd("filetype on")
vim.g.mapleader = " "
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
map("n", "<leader>w", ":bdelete<CR>", opts)
map("n", "<leader>e", ":Lexplore<CR>", opts)
map("n", "<leader>s", ":w<CR>", opts)
map("n", "<leader>q", ":q<CR>", opts)
map("n", "<leader>p", ":find ", { noremap = true })
map("n", "<leader>f", [[:execute 'find ' .. expand('<cword>') .. '.' .. &filetype<CR>]], opts)
map("n", "<leader>F", [[:execute 'vimgrep /' .. expand('<cword>') .. '/' '**/*.' .. &filetype<CR>]], opts)
map("n", "<leader>S", ":Startify<CR>", opts)
map("n", "<S-l>", ":bnext<CR>", opts)
map("n", "<S-h>", ":bprevious<CR>", opts)
map("n", "<S-j>", "<C-f><CR>", opts)
map("n", "<S-k>", "<C-b><CR>", opts)
map("n", "<Up>", ":cprevious<CR>", opts)
map("n", "<Down>", ":cnext<CR>", opts)
map("n", "<F6>", ":!scripts/run.sh<CR>", opts)
vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, opts)

vim.opt.path:append("**")
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.wildmenu = true
vim.opt.number = true
vim.opt.wildignore:append("*.md")
vim.opt.mouse = ""
vim.g.netrw_winsize = 25
vim.g.netrw_liststyle = 3
vim.g.netrw_banner = 0

local Plug = vim.fn['plug#']
vim.call('plug#begin', '~/.config/nvim/plugged')
Plug 'folke/tokyonight.nvim'
Plug 'mhinz/vim-startify'
Plug 'neovim/nvim-lspconfig'
vim.call('plug#end')

vim.cmd("colorscheme tokyonight-night")
vim.api.nvim_set_hl(0, "LineNr", { fg = "#b0b0b0" })
vim.g.startify_lists = {
    { type = 'sessions', header = { '   Saved Sessions' } },
}

vim.api.nvim_set_keymap('n', 'R', [[:lua FindAndReplace()<CR>]], { noremap = true, silent = true })

function FindAndReplace()
    local old = vim.fn.expand('<cword>')
    local new = vim.fn.input("Replace " .. old .. " with: ")
    if new ~= "" then
        vim.cmd('%s/' .. old .. '/' .. new .. '/gc')
    end
end

require 'lspconfig'.lua_ls.setup {
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
require 'lspconfig'.terraformls.setup {}

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*.tf", "*.tfvars", "*.lua" },
    callback = function()
        vim.lsp.buf.format()
    end,
})
