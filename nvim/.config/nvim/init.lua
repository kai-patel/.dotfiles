-- Load .vim first
local vimrc = vim.fn.stdpath("config") .. "/start.vim"
vim.cmd.source(vimrc)

-- Order matters
require('user.treesitter')
require('user.lsp')
require('user.git')
require('user.telescope')
