-- Install lazy.nvim
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'

if not vim.loop.fs_stat(lazypath) then
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
  defaults = { lazy = true },
  install = { missing = true, colorscheme = { 'rose-pine-moon' } },
  checker = { enabled = false },
  change_detection = { enabled = true, notify = false },
  lockfile = vim.fn.stdpath('config') .. '/lazy-lock.json',
  ui = { border = 'rounded' },
  performance = {
    rtp = {
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
      },
    },
  },
  readme = { enabled = false },
})
