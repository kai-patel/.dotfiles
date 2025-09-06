return {
    "github/copilot.vim",
    init = function()
        vim.g.copilot_node_command = "node"
        vim.g.copilot_proxy_strict_ssl = false
        vim.g.copilot_proxy = ""
    end
}
