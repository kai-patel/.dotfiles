return {
    "Olical/conjure",
    config = function()
        -- `g:conjure#filetypes`
        vim.api.nvim_set_var("conjure#filetypes", { "clojure" })
    end
}
