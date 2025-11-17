-- LSP
-- Servers

local function file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

local clangd_opts = {}
if file_exists("start_lsp.sh") then
    clangd_opts = {
        cmd = { vim.fn.getcwd() .. "/start_lsp.sh" },
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        on_attach = function(_, _)
            -- require("clangd_extensions.inlay_hints").setup_autocmd()
            -- require("clangd_extensions.inlay_hints").set_inlay_hints()
        end
    }
else
    clangd_opts = {
        filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        on_attach = function(_, _)
            -- require("clangd_extensions.inlay_hints").setup_autocmd()
            -- require("clangd_extensions.inlay_hints").set_inlay_hints()
        end
    }
end

local lsp_opts = {
    servers = {
        lua_ls = {},
        clangd = clangd_opts,
        protols = {},
        bashls = { cmd = { "bunx", "bash-language-server", "start" } },
        marksman = {},
        yamlls = {},
        neocmake = {},
        ruff = {},
        pyright = {
            settings = {
                pyright = {
                    disableOrganizeImports = true,
                },
                python = {
                    analysis = {
                        ignore = { '*' },
                    }
                }
            }

        },
        gopls = {
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    gofumpt = true,
                },
            },

        },
        zls = {},
        rust_analyzer = { settings = { ['rust-analyzer'] = { cargo = { allTargets = false } } } },
        texlab = {},
        biome = { cmd = { "bunx", "@biomejs/biome", "lsp-proxy" }, workspace_required = false },
        ts_ls = { cmd = { "bunx", "typescript-language-server", "--stdio" } },
        tailwindcss = {},
        powershell_es = {
            bundle_path = "C:/Users/kpatel/Documents/PowerShellEditorServices/",
            shell = "/mnt/c/Users/kpatel/Downloads/PowerShell-7.5.3-win-x64/pwsh.exe",
        },
        dotls = { cmd = { "bunx", "dot-language-server", "--stdio" } },
        hls = { filetypes = { 'haskell', 'lhaskell', 'cabal' } },
        tinymist = { settings = { formatterMode = "typstyle", exportPdf = "onType", semanticTokens = true } },
        jqls = {},
    }
}

for server, config in pairs(lsp_opts.servers) do
    config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
end

-- Globals

-- After LSP has attached
vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', {}),
    callback = function(ev)
        -- Enable completion triggered by <c-x><c-o>
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        -- Buffer local mappings.
        -- See `:help vim.lsp.*` for documentation on any of the below functions
        local opts = { buffer = ev.buf }
        vim.keymap.set('n', 'g[', function() vim.diagnostic.jump({ count = -1, float = true }) end, opts)
        vim.keymap.set('n', 'g]', function() vim.diagnostic.jump({ count = 1, float = true }) end, opts)
        vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, opts)
        vim.keymap.set('i', '<C-S>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'grI', vim.lsp.buf.incoming_calls, opts)
        vim.keymap.set('n', '<S-A-F>', function()
            vim.lsp.buf.format { async = true, filter = function(client) return client.name ~= "ts_ls" end }
        end, opts)
        vim.keymap.set('n', '<leader>s', ":ClangdSwitchSourceHeader<cr>")
    end,
})
