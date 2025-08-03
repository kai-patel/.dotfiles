return {
    "vlime/vlime",
    config = function(plugin)
        vim.opt.rtp:append(plugin.dir .. "/vim")
    end,
    init = function()
        vim.g.vlime_compiler_policy = { DEBUG = 3 }
        vim.g.vlime_enable_autodoc = true
    end
}
