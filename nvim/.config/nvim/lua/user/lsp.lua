-- LSP

-- Setup neodev before lspconfig
local neodev = require("neodev").setup({})

local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')

-- Servers

-- Lua
lspconfig.lua_ls.setup {
    capabilities = capabilities,
}

-- Flex C++
-- require('lspconfig.configs').docker_clangd = {
--     default_config = {
--         -- cmd = { "docker", "exec", "lsp", "sh -c 'clangd --compile-commands-dir=./kai'" },
--         cmd = { "./start_lsp.sh" },
--         filetypes = { 'cpp' },
--         root_dir = lspconfig.util.root_pattern("start_lsp.sh"),
--         settings = {},
--     },
-- }

lspconfig.clangd.setup {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        require("clangd_extensions.inlay_hints").setup_autocmd()
        require("clangd_extensions.inlay_hints").set_inlay_hints()
    end
}

-- Bash
lspconfig.bashls.setup {
    capabilities = capabilities
}

-- Markdown
lspconfig.marksman.setup {
    capabilities = capabilities
}

-- YAML
lspconfig.yamlls.setup {
    capabilities = capabilities
}

-- CMake
lspconfig.neocmake.setup {
    capabilities = capabilities
}

-- Python
lspconfig.pylsp.setup {
    capabilities = capabilities,
    settings = {
        pylsp = {
            configurationSources = { "flake8" },
            plugins = {
                flake8 = {
                    enabled = true
                },
                pycodestyle = {
                    enabled = false
                },
                mccabe = {
                    enabled = false
                },
                pyflakes = {
                    enabled = false
                },
            }
        }
    }
}

-- Golang
lspconfig.gopls.setup({
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
        },
    },
})

-- Zig
lspconfig.zls.setup({
    capabilities = capabilities
})

-- Rust
lspconfig.rust_analyzer.setup({
    capabilities = capabilities
})

-- Latex
lspconfig.texlab.setup {
    capabilities = capabilities
}

-- nvim-cmp
local cmp = require('cmp')

cmp.setup({
    snippet = {
        -- REQUIRED - you must specify a snippet engine
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'vsnip' }, -- For vsnip users.
        -- { name = 'luasnip' }, -- For luasnip users.
        -- { name = 'ultisnips' }, -- For ultisnips users.
        -- { name = 'snippy' }, -- For snippy users.
        { name = 'nvim_lsp_signature_help' },
        { name = 'rpncalc' },
    }, {
        { name = 'buffer' },
    })
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'nvim_lsp_document_symbol' },
    }, {
        { name = 'buffer' }
    })
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})

-- trouble.nvim
local trouble = require('trouble')
trouble.setup({
    -- settings without a patched font or icons
    icons = false,
    fold_open = "v",      -- icon used for open folds
    fold_closed = ">",    -- icon used for closed folds
    indent_lines = false, -- add an indent guide below the fold icons
    signs = {
        -- icons / text used for a diagnostic
        error = "error",
        warning = "warn",
        hint = "hint",
        information = "info"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
})

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
        vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev)
        vim.keymap.set('n', 'g]', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', '<leader>i', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', '<leader>I', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<leader>c', vim.lsp.buf.incoming_calls, opts)
        vim.keymap.set('n', '<S-A-F>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('v', '<S-A-F>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set("n", "<leader>d", function() require("trouble").toggle("workspace_diagnostics") end)
        vim.keymap.set('n', '<leader>s', ":ClangdSwitchSourceHeader<cr>")

        -- Inlay hints (if supported)
        -- local client = vim.lsp.get_client_by_id(args.data.client_id)
        -- if client.server_capabilities.inlayHintProvider then
        --     vim.lsp.inlay_hint.enable(args.buf, true)
        -- end
    end,
})

require 'treesitter-context'.setup {
    enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0,            -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0,    -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer',     -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    mode = 'cursor',          -- Line used to calculate context. Choices: 'cursor', 'topline'
    -- Separator between context and content. Should be a single character string, like '-'.
    -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
    separator = nil,
    zindex = 20,     -- The Z-index of the context window
    on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

require 'nvim-treesitter.configs'.setup {
    refactor = {
        highlight_definitions = {
            enable = false,
            -- Set to false if you have an `updatetime` of ~100.
            clear_on_cursor_move = false,
        },
        highlight_current_scope = { enable = false }
    },
}
