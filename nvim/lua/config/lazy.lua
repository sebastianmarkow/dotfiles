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

-- Protect bootstrapping lazy.nvim
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
    print("warn: lazy installing, please restart neovim")
    return
end

lazy.setup({
    spec = {
        { import = "plugins.ui" },
        { import = "plugins.edit" },
        { import = "plugins.git" },
        { import = "plugins.lsp" },
        { import = "plugins.dap" },
        { import = "plugins.treesitter" },
        { import = "plugins.filetype" },
    },
    lockfile = vim.fn.stdpath("config") .. "/lazy-lock.json",
    ui = {
        size = {
            width = 0.8,
            height = 0.8,
        },
        wrap = true,
        border = "rounded",
    },
    performance = {
        cache = {
            enabled = true,
        },
        reset_packpath = true,
        rtp = {
            disabled_plugins = {
                "getscript",
                "getscriptPlugin",
                "gzip",
                "matchit",
                "matchparen",
                "netrw",
                "netrwFileHandlers",
                "netrwPlugin",
                "rrhelper",
                "tar",
                "tarPlugin",
                "tohtml",
                "tutor",
                "vimball",
                "vimballPlugin",
                "zip",
                "zipPlugin",
            },
        },
    },
})
