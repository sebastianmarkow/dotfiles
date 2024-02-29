-- Install lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--single-branch",
        "https://github.com/folke/lazy.nvim.git",
        lazypath,
    })
end
vim.opt.runtimepath:prepend(lazypath)

local icons = require("config.icons")

require("lazy").setup({
    spec = {
        { import = "plugins.ui" },
        { import = "plugins.edit" },
        { import = "plugins.git" },
        { import = "plugins.lsp" },
        { import = "plugins.dap" },
        { import = "plugins.treesitter" },
        { import = "plugins.filetype" },
    },
    defaults = { lazy = true },
    install = {
        missing = true,
        colorscheme = { "rose-pine" },
    },
    checker = {
        enabled = true,
        notify = false,
        frequency = 86400, -- check daily
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
    ui = {
        border = "rounded",
        icons = {
            loaded = icons.plugins.Installed,
            not_loaded = icons.plugins.Uninstalled,
        }
    },
    performance = {
        rtp = {
            disabled_plugins = {
                    "gzip",
                    "matchit",
                    "matchparen",
                    "netrwPlugin",
                    "tarPlugin",
                    "tohtml",
                    "tutor",
                    "zipPlugin",
            },
        },
    },
    readme = {
        enabled = false,
    }
})
