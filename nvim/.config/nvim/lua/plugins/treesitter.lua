return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
        local configs = require('nvim-treesitter.configs')
        configs.setup {
            refactor = {
                highlight_definitions = {
                    enable = false,
                    clear_on_cursor_move = false,
                },
                highlight_current_scope = { enable = false }
            },
            ensure_installed = { "cpp", "c", "dockerfile", "comment", "bash", "cmake", "make", "json", "proto", "yaml", "python", "lua", "vimdoc" },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
        }
    end
}
