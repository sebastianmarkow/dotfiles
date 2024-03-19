return {
    {
        "windwp/nvim-autopairs",
        dependencies = {
            "hrsh7th/nvim-cmp",
        },
        event = "InsertEnter",
        config = function()
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")

            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

            require("nvim-autopairs").setup({
                check_ts = true,
                ts_config = {
                    lua = { "string" },
                },
            })
        end,
    },
    {
        "ethanholz/nvim-lastplace",
        event = { "BufReadPre" },
        opts = {
            lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
            lastplace_ignore_filetype = { "gitcommit", "gitrebase" },
            lastplace_open_folds = false,
        },
    },
    {
        "monkoose/matchparen.nvim",
        event = "VeryLazy",
        config = function()
            require("matchparen").setup({
                on_startup = true,
                hl_group = "MatchParen",
                debounce_time = 100,
            })
        end,
    },
    {
        "numToStr/Comment.nvim",
        event = "BufEnter",
        config = true,
    },
    {
        "lewis6991/fileline.nvim",
        lazy = false,
    },
    {
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
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
    },
}
