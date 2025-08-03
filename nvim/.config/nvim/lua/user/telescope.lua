-- Telescope
local telescope = require('telescope')
telescope.load_extension('fzf')

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.api.nvim_create_user_command('Files', builtin.find_files, {})
vim.api.nvim_create_user_command('Rg', builtin.live_grep, {})
vim.api.nvim_create_user_command('Symbols', builtin.treesitter, {})
vim.api.nvim_create_user_command('Buffers', builtin.buffers, {})
vim.api.nvim_create_user_command('Branches', builtin.git_branches, {})
vim.api.nvim_create_user_command('Commits', builtin.git_commits, {})
vim.api.nvim_create_user_command('BCommits', builtin.git_bcommits, {})
