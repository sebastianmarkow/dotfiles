return {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000,
    config = function()
        require("rose-pine").setup({
            variant = "moon",
            dim_inactive_windows = true,
            styles = {
                italic = false,
                bold = true,
            },
            highlight_groups = {
                Comment = { italic = true },
            }
        })

        vim.cmd[[colorscheme rose-pine]]
    end,
}
