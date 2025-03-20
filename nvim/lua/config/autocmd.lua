-- Markdown
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function() vim.bo.textwidth = 80 end,
})

-- Golang
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'go',
  callback = function()
    vim.bo.expandtab = false
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
  end,
})

-- Python
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'python',
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
  end,
})

-- Terraform/Terragrunt
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'terraform', 'terragrunt' },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})

-- Lua/Fish/Bash
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'lua', 'fish', 'bash' },
  callback = function()
    vim.bo.expandtab = true
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
  end,
})

-- Git Config
vim.api.nvim_create_autocmd('BufRead', {
  pattern = { 'gitconfig' },
  callback = function() vim.opt.filetype = 'gitconfig' end,
})

-- Cursorline only in active window
local cursor_group = vim.api.nvim_create_augroup('CursorLine', { clear = true })
vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  pattern = '*',
  command = 'set cursorline',
  group = cursor_group,
  desc = 'show cursor line only in active window',
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  pattern = '*',
  command = 'set nocursorline',
  group = cursor_group,
})
