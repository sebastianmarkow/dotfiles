return {
    "RRethy/vim-illuminate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    event = { "BufReadPost", "BufNewFile" },
    opts = {
        delay = 200,
        filetypes_denylist = {
            "help",
        },
    },
    config = function(_, opts)
        require("illuminate").configure(opts)
    end,
}
