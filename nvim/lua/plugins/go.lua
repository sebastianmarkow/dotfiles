return {
    "ray-x/go.nvim",
    dependencies = {
        "neovim/nvim-lspconfig",
        "leoluz/nvim-dap-go",
        "hrsh7th/cmp-nvim-lsp",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {},
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
}
