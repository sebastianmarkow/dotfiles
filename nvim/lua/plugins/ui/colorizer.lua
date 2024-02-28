return {
    "norcalli/nvim-colorizer.lua",
    event = { "BufRead" },
    config = function()
        require('colorizer').setup {
            'toml',
            'yaml',
            'lua',
            'tmux',
            html = {
                mode = 'foreground',
            }
        }
    end,
}
