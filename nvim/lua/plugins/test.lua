local icons = require("config.icons")

return {
    "nvim-neotest/neotest",
    ft = { "go" },
    dependencies = {
        "nvim-lua/plenary.nvim",
        "antoinemadec/FixCursorHold.nvim",
        "nvim-treesitter/nvim-treesitter",
        "nvim-neotest/neotest-go",
    },
    config = function()
        ---@diagnostic disable: missing-fields
        require('neotest').setup({
            icons = {
                running_animated = icons.animated.spinner,
                passed = "v",
            },
            discovery = { enabled = true },
            diagnostic = { enabled = true },
            floating = { border = "rounded" },
            quickfix = { enabled = false, open = true },
            adapters = {
                require('neotest-go'),
            },
        })
    end,
}
