return {
    "ray-x/go.nvim",
    event = {
        "BufRead *.go,*.mod,*.sum",
        "BufNewFile *.go,*.mod,*.sum",
    },
    dependencies = {
        "neovim/nvim-lspconfig",
        "mason-lspconfig.nvim",
    },
    opts = {},
}
