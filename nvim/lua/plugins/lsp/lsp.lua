return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "williamboman/mason.nvim",
        "hrsh7th/cmp-nvim-lsp",
        {
            "j-hui/fidget.nvim",
            opts = {},
        },
    },
    opts = {
        diagnostics = {
            underline = true,
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = "if_many",
                prefix = "●",
            },
            severity_sort = true,
            float = {
                show_header = true,
                border = "rounded",
                source = "always",
            },
        },
    },
    config = function(_, opts)
        local lspconfig = require("lspconfig")
        local cmp = require("cmp_nvim_lsp")
        local merge = vim.tbl_deep_extend

        vim.diagnostic.config(opts.diagnostics)

        require("lspconfig.ui.windows").default_options.border = "rounded"

        lspconfig.util.default_config.capabilities =
            merge("force", lspconfig.util.default_config.capabilities, cmp.default_capabilities())
    end,
}
