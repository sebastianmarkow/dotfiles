return {
    "rhysd/committia.vim",
    event = "BufEnter",
    config = function()
        vim.g.committia_open_only_vim_starting = 0
        vim.g.committia_min_window_width = 160
        vim.g.committia_hooks = vim.empty_dict()
    end,
}
