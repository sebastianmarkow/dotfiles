return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")
        gitsigns.setup({
            signs = {
                add = { text = "▐" },
                change = { text = "▐" },
                delete = { text = "▐" },
                topdelete = { text = "▐" },
                changedelete = { text = "▐" },
                untracked = { text = "▐" },
            },
            signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
            linehl = false,    -- Toggle with `:Gitsigns toggle_linehl`
            numhl = false,     -- Toggle with `:Gitsigns toggle_nunhl`
            word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
            sign_priority = 6,
            watch_gitdir = {
                interval = 1000,
            },
            attach_to_untracked = false,
        })
    end,
}
