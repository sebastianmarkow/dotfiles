return {
    {
        "williamboman/mason-lspconfig.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            automatic_installation = true,
            ensure_installed = {
                "gopls",
                "lua_ls",
                "pyright",
            },
        },
        config = function(_, opts)
            local mason = require("mason-lspconfig")
            mason.setup(opts)
            mason.setup_handlers({
                function(server)
                    require("lspconfig")[server].setup({})
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                border = "rounded",
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },
}
