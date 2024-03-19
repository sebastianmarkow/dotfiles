return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        config = function()
            local treesitter = require("nvim-treesitter.configs")
            treesitter.setup({
                modules = {},
                sync_install = false,
                auto_install = true,
                ignore_install = {},
                ensure_installed = {
                    "bash",
                    "css",
                    "diff",
                    "dockerfile",
                    "fish",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "graphql",
                    "hcl",
                    "html",
                    "http",
                    "javascript",
                    "json",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "regex",
                    "rust",
                    "scss",
                    "sql",
                    "terraform",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "yaml",
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
            })
        end,
        build = function()
            vim.cmd("TSUpdate")
        end,
    },
}
