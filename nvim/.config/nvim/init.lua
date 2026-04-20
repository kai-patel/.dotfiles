vim.opt.mouse = "n"
vim.g.mapleader = [[#]]
vim.g.maplocalleader = "z"
vim.opt.path = vim.opt.path + "**"
vim.opt.colorcolumn = "80"
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.list = true
vim.opt.listchars = { tab = "→ ", trail = "•", extends = "#", nbsp = "." }
vim.opt.showcmd = true
vim.opt.wildmenu = true
vim.opt.lazyredraw = true
vim.opt.showmatch = true
vim.opt.incsearch = true
vim.opt.hlsearch = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.backspace = { "indent", "eol", "start" }
vim.opt.encoding = "utf-8"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")
vim.keymap.set("n", "<C-h>", "<C-w>h")
vim.keymap.set("n", "<space>", "za")
vim.cmd.filetype("plugin indent on")
vim.cmd.syntax("enable")
vim.opt.completeopt = { "popup", "noinsert", "noselect" }
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "gj", "j")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "gk", "k")
vim.opt.belloff = "esc"
vim.opt.pumheight = 10
vim.opt.showmode = true
vim.opt.laststatus = 2
vim.opt.statusline = nil
vim.opt.statusline = vim.opt.statusline + "%1*"
vim.opt.statusline = vim.opt.statusline + " %t "
vim.opt.statusline = vim.opt.statusline + "%2*"
vim.opt.statusline = vim.opt.statusline + " "
vim.opt.statusline = vim.opt.statusline + "%y"
vim.opt.statusline = vim.opt.statusline + " [%b, %B]"
vim.opt.statusline = vim.opt.statusline + " %LL"
vim.opt.statusline = vim.opt.statusline + " %{FugitiveStatusline()}"
vim.opt.statusline = vim.opt.statusline + " %m"
vim.opt.statusline = vim.opt.statusline + "%="
vim.opt.statusline = vim.opt.statusline + "%3*"
vim.opt.statusline = vim.opt.statusline + " [%l, %c]"
vim.opt.statusline = vim.opt.statusline + " %p%% "
vim.api.nvim_set_hl(0, [[User1]], { ctermbg = "darkgray", ctermfg = "white" })
vim.api.nvim_set_hl(0, [[User2]], { ctermbg = "lightgray", ctermfg = "black" })
vim.api.nvim_set_hl(0, [[User3]], { ctermbg = "black", ctermfg = "white" })
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 50
vim.keymap.set("n", "<leader>w", ":w !clip.exe<CR>", { silent = true })
vim.keymap.set("v", "<leader>w", ":'<,'>w !clip.exe<CR>", { silent = true })
vim.lsp.set_log_level("ERROR")
vim.opt.textwidth = 80

require("config.lazy")
require("user.telescope")
require("user.oil")
require("user.brackets")
require("user.lsp")
require("user.vimwiki")
