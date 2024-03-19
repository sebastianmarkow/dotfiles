local icons = require("config.icons")

return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason-lspconfig.nvim",
            "williamboman/mason.nvim",
            "hrsh7th/cmp-nvim-lsp",
            "j-hui/fidget.nvim",
            "folke/neodev.nvim",
        },
        opts = {
            mason = {
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = icons.plugins.Installed,
                        package_pending = icons.plugins.Pending,
                        package_uninstalled = icons.plugins.Uninstalled,
                    },
                },
            },
            mason_lspconfig = {
                automatic_installation = true,
                ensure_installed = {
                    "gopls",
                    "pyright",
                    "lua_ls",
                },
            },
            fidget = {
                progress = {
                    display = {
                        done_icon = icons.plugins.Installed .. " ",
                    },
                },
                notification = {
                    window = {
                        border = "rounded",
                    },
                },
            },
            diagnostics = {
                underline = true,
                update_in_insert = false,
                virtual_text = {
                    spacing = 0,
                    source = false,
                    prefix = "",
                },
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = icons.diagnostics.Error,
                        [vim.diagnostic.severity.WARN] = icons.diagnostics.Warn,
                        [vim.diagnostic.severity.INFO] = icons.diagnostics.Info,
                        [vim.diagnostic.severity.HINT] = icons.diagnostics.Hint,
                    },
                },
                severity_sort = true,
                float = {
                    style = "minimal",
                    border = "rounded",
                    source = "always",
                    header = "",
                    prefix = "",
                },
            },
            servers = {
                gopls = {},
                lua_ls = {
                    Lua = {
                        telemetry = { enable = false },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        workspace = {
                            -- make language server aware of runtime files
                            library = {
                                [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                                [vim.fn.stdpath("config") .. "/lua"] = true,
                            },
                        },
                    },
                },
                pyright = {},
            },
        },
        config = function(_, opts)
            -- setup Mason
            require("mason").setup(opts.mason)

            -- setup Mason LSP Config
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup(opts.mason_lspconfig)

            -- setup NeoDev
            require("neodev").setup({
                library = { plugins = { "neotest" }, types = true },
            })

            -- LSP capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

            mason_lspconfig.setup_handlers({
                function(server_name)
                    require("lspconfig")[server_name].setup({
                        capabilities = capabilities,
                        settings = opts.servers[server_name],
                        filetypes = (opts.servers[server_name] or {}).filetypes,
                    })
                end,
            })

            vim.diagnostic.config(opts.diagnostics)

            require("lspconfig.ui.windows").default_options.border = "rounded"

            -- setup Fidget
            require("fidget").setup(opts.fidget)
        end,
    },
    {
        "nvimtools/none-ls.nvim",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "jay-babu/mason-null-ls.nvim",
            "nvim-lua/plenary.nvim",
            "nvimtools/none-ls-extras.nvim",
            "gbprod/none-ls-shellcheck.nvim",
        },
        config = function()
            require("null-ls").register(require("none-ls-shellcheck.diagnostics"))
            require("null-ls").register(require("none-ls-shellcheck.code_actions"))

            local mason_null_ls = require("mason-null-ls")
            local null_ls = require("null-ls")

            local null_ls_utils = require("null-ls.utils")

            mason_null_ls.setup({
                ensure_installed = {
                    "black", -- python formatter
                    "buf", -- buf formatter
                    "eslint_d", -- js linter
                    "golangci_lint", -- go linter
                    "prettier", -- prettier formatter
                    "shellcheck", -- shell linter
                    "shfmt", -- shell formatter
                    "spell", -- spell checker
                    "stylua", -- lua formatter
                    "terraform_fmt", -- terraform formatter
                    "terraform_validate", -- terraform linter
                    "yamlfmt", -- yaml formatter
                    "yamllint", -- yaml linter
                },
            })

            local formatting = null_ls.builtins.formatting
            local diagnostics = null_ls.builtins.diagnostics
            local code_actions = null_ls.builtins.code_actions

            null_ls.setup({
                root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),

                sources = {
                    diagnostics.golangci_lint,
                    diagnostics.shellcheck,
                    diagnostics.terraform_validate,
                    diagnostics.yamllint,
                    formatting.black,
                    formatting.buf,
                    formatting.prettier,
                    formatting.shfmt,
                    formatting.stylua,
                    formatting.terraform_fmt,
                    formatting.yamlfmt,
                    code_actions.gitsigns,
                    code_actions.refactoring,
                },
            })
        end,
    },
}
