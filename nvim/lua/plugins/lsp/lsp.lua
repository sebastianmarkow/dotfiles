local icons = require('config.icons')

return {
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
                }
            },
            notification = {
                window = {
                    border = "rounded",
                }
            }
        },
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
                spacing = 0,
                source = false,
                prefix = "",
            },
            signs = true,
            severity_sort = true,
            float = {
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        },
        diagnostics_signs = {
            Error = icons.diagnostics.Error,
            Warn = icons.diagnostics.Warn,
            Hint = icons.diagnostics.Hint,
            Info = icons.diagnostics.Info,
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
        require("neodev").setup()

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

        for type, icon in pairs(opts.diagnostics_signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
        end

        require("lspconfig.ui.windows").default_options.border = "rounded"

        -- setup Fidget
        require("fidget").setup(opts.fidget)

    end,
}
