return {
    "junegunn/vim-easy-align",
    init = function()
        vim.keymap.set("x", "ga", "<Plug>(EasyAlign)", { noremap = false, silent = true })
    end
}
