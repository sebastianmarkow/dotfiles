-- Install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    'https://github.com/folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

require('lazy').setup({
  spec = { { import = 'plugins' } },
  defaults = { 
    lazy = true,
    -- Disable module = true for non-module plugins for faster require performance
    module = false,
  },
  install = { missing = true, colorscheme = { 'rose-pine-moon' } },
  checker = { enabled = false },
  change_detection = { enabled = true, notify = false },
  lockfile = vim.fn.stdpath('config') .. '/lazy-lock.json',
  ui = { border = 'rounded' },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true,
    rtp = {
      reset = true,
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'rPlugin',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
        'shada',
        'spellfile',
      },
    },
  },
  readme = { enabled = false },
})
