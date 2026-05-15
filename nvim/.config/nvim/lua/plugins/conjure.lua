return {
    "Olical/conjure",
    init = function()
        -- `g:conjure#filetypes`
        vim.api.nvim_set_var("conjure#filetypes", { "clojure" })
    end
}
