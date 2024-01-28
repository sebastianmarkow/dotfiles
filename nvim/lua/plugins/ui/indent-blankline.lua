return {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufRead" },
    main = "ibl",
    opts = {
        indent = {
            char = "┊",
        },
        scope = {
            show_start = false,
            show_end = false,
        },
        exclude = {
            filetypes = {
                "",
                "checkhealth",
                "gitcommit",
                "help",
                "help",
                "lazy",
                "lspinfo",
                "man",
                "mason",
                "terminal",
            },
        },
    },
}
