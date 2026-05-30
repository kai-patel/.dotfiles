return {
    "shumphrey/fugitive-gitlab.vim",
    config = function()
        vim.g.fugitive_gitlab_domains = {
            "https://git.flextrade.com",
        }
        local token_files = vim.api.nvim_get_runtime_file("GITLAB_TOKEN", false);
        if #token_files < 1 then
            vim.notify("No GITLAB_TOKEN file found in runtimepath", vim.log.levels.ERROR);
        else
            local token_file = io.open(token_files[1], "r");
            if token_file == nil then
                vim.notify("Failed to open GITLAB_TOKEN file", vim.log.levels.ERROR);
            else
                local token = token_file:read();
                token_file:close();
                vim.g.fugitive_gitlab_token = token;
            end
        end
    end
}
