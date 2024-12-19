-- LSP

-- Setup neodev before lspconfig
local _ = require("neodev").setup({})

local lspconfig = require('lspconfig')

require("clangd_extensions").setup({
    inlay_hints = {
        inline = true,
    }
})


-- Servers

local function file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

local clangd_opts = {}
if file_exists("start_lsp.sh") then
    clangd_opts = {
        cmd = "./start_lsp.sh",
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
        bashls = {},
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
        biome = {},
        ts_ls = {},
        tailwindcss = {},
    }
}

-- blink.cmp
require('blink.cmp').setup({
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = { preset = 'enter' },
    appearance = {
        -- Sets the fallback highlight groups to nvim-cmp's highlight groups
        -- Useful for when your theme doesn't support blink.cmp
        -- will be removed in a future release
        use_nvim_cmp_as_default = true,
        -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = "mono",
    },

    completion = {
        menu = {
            border = 'rounded',
            treesitter = true,
            draw = {
                columns = { { 'label', 'label_description', gap = 1 } }
            }
        },
        documentation = {
            auto_show = true,
            window = {
                border = 'rounded',
            },
        },
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
        -- optionally disable cmdline completions
        -- cmdline = {},
    },

    -- experimental signature help support
    signature = { enabled = true }
}
)


for server, config in pairs(lsp_opts.servers) do
    -- passing config.capabilities to blink.cmp merges with the capabilities in your
    -- `opts[server].capabilities, if you've defined it
    config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
    lspconfig[server].setup(config)
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
        vim.keymap.set('n', 'g[', vim.diagnostic.goto_prev)
        vim.keymap.set('n', 'g]', vim.diagnostic.goto_next)
        vim.keymap.set('n', '<leader>g', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gri', vim.lsp.buf.implementation, opts)
        vim.keymap.set('i', '<C-S>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', 'grn', vim.lsp.buf.rename, opts)
        vim.keymap.set({ 'n', 'v' }, 'gra', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'grr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', 'grI', vim.lsp.buf.incoming_calls, opts)
        vim.keymap.set('n', '<S-A-F>', function()
            vim.lsp.buf.format { async = true }
        end, opts)
        vim.keymap.set('n', "gO", vim.lsp.buf.document_symbol, opts)
        vim.keymap.set('n', '<leader>s', ":ClangdSwitchSourceHeader<cr>")
    end,
})

require 'treesitter-context'.setup {
    enable = true,            -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 1,            -- How many lines the window should span. Values <= 0 mean no limit.
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
