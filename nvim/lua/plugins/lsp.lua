local icons = require("config.icons")

local function on_attach(_, bufnr)
    local opts = { noremap = true, silent = true }
    local keymap = vim.api.nvim_buf_set_keymap
    -- Example key mappings
    keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
    keymap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
end

return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "j-hui/fidget.nvim",
        },
        event = { "BufReadPre", "BufNewFile" },
        cmd = "Mason",
        opts = {
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 0, source = false, prefix = "" },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.error,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.warn,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.info,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.hint,
                    },
                },
                severity_sort = true,
                float = { style = "minimal", border = "rounded", source = "always", header = "", prefix = "" },
            },
            fidget = { notification = { window = { border = "rounded" } } },
            servers = {
                gopls = { filetypes = { "go" }, settings = {} },
                lua_ls = {
                    filetypes = { "lua" },
                    settings = {
                        Lua = {
                            telemetry = { enable = false },
                            diagnostics = { globals = { "vim" } },
                            workspace = {
                                -- make language server aware of runtime files
                                library = {
                                    [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                    [vim.fn.stdpath("config") .. "/lua"] = true,
                                },
                            },
                        },
                    },
                },
                pylsp = {
                    filetypes = { "python" },
                    settings = {
                        pylsp = {
                            plugins = {
                                -- formatter options
                                black = { enabled = true },
                                autopep8 = { enabled = false },
                                yapf = { enabled = false },
                                -- linter options
                                pylint = { enabled = true },
                                ruff = { enabled = false },
                                pyflakes = { enabled = false },
                                pycodestyle = { enabled = false },
                                -- type checker
                                pylsp_mypy = { enabled = true, report_progress = true, live_mode = false },
                                -- auto-completion options
                                jedi_completion = { fuzzy = true },
                                -- import sorting
                                isort = { enabled = true },
                            },
                        },
                    },
                },
                rust_analzyer = { filetypes = { "rust" }, settings = {} },
            },
        },
        config = function(_, opts)
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason").setup()
            require("mason-lspconfig").setup({
                handlers = {
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = capabilities,
                            on_attach = on_attach,
                            settings = (opts.servers[server_name] or {}).settings,
                            filetypes = (opts.servers[server_name] or {}).filetypes,
                        })
                    end,
                },
            })
            require("fidget").setup(opts.fidget)
            vim.diagnostic.config(opts.diagnostics)
        end,
    },
}
