local icons = require("config.icons")
local utils = require("config.utils")

local py_path = nil

if utils.executable("pylsp") then
    local venv_path = os.getenv('VIRTUAL_ENV')
    -- decide which python executable to use for mypy
    if venv_path ~= nil then
        py_path = venv_path .. "/bin/python3"
    else
        py_path = vim.g.python3_host_prog
    end
else
    vim.notify("pylsp not found", vim.log.levels.WARN, { title = "dotfiles" })
end

local function on_attach(client, bufnr)
    local opts = { noremap = true, silent = true}
    local keymap = vim.api.nvim_buf_set_keymap
    -- Example key mappings
    keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
    vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

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
                    "pylsp",
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
                pylsp = {
                    pylsp = {
                        plugins = {
                            -- formatter options
                            black = { enabled = true },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },
                            -- linter options
                            pylint = { enabled = true, executable = "pylint" },
                            ruff = { enabled = false },
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            -- type checker
                            pylsp_mypy = {
                                enabled = true,
                                overrides = { "--python-executable", py_path, true },
                                report_progress = true,
                                live_mode = false
                            },
                            -- auto-completion options
                            jedi_completion = { fuzzy = true },
                            -- import sorting
                            isort = { enabled = true },
                        },
                    },
                },
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
                        on_attach = on_attach,
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
        },
        config = function()
            local mason_null_ls = require("mason-null-ls")
            local null_ls = require("null-ls")

            local null_ls_utils = require("null-ls.utils")

            mason_null_ls.setup({
                ensure_installed = {
                    "buf", -- buf formatter
                    "eslint_d", -- js linter
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
                    diagnostics.terraform_validate,
                    diagnostics.yamllint,
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
