-- Treesitter

require('nvim-treesitter.configs').setup {
    -- one of "all", "maintained" (parsers with maintainers),
    -- or a list of languages
    ensure_installed = { "cpp", "c", "dockerfile", "comment", "bash", "cmake", "make", "json", "proto", "yaml", "python", "lua", "vimdoc" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
}
