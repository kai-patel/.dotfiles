vim.g.vimwiki_list = {
    {
        path = "~/vimwiki/",
        syntax = "default",
        ext = ".wiki",
        auto_export = 1,
        auto_toc = 1,
    }
}
vim.g.vimwiki_global_ext = 0
-- vim.g.vimwiki_ext2syntax = {}
vim.call("vimwiki#vars#init")
