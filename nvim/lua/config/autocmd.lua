-- Group file type settings in a single augroup
local filetype_group = vim.api.nvim_create_augroup('FiletypeSettings', { clear = true })

-- 80 chars width
vim.api.nvim_create_autocmd('FileType', {
  group = filetype_group,
  pattern = 'markdown',
  callback = function() vim.bo.textwidth = 80 end,
})

-- Setup indentation by filetype (single autocmd with multiple patterns)
local indentation_settings = {
  -- tabs with 4 spaces width
  [{ 'go' }] = { expandtab = false, tabstop = 4, shiftwidth = 4, softtabstop = 4 },
  -- spaces with 4 spaces width
  [{ 'python' }] = { expandtab = true, tabstop = 4, shiftwidth = 4, softtabstop = 4 },
  -- spaces with 2 spaces width
  [{ 'terraform', 'terragrunt', 'lua', 'fish', 'bash' }] = { expandtab = true, tabstop = 2, shiftwidth = 2, softtabstop = 2 },
}

-- Create a single autocmd for each indentation style
for patterns, settings in pairs(indentation_settings) do
  vim.api.nvim_create_autocmd('FileType', {
    group = filetype_group,
    pattern = patterns,
    callback = function()
      for setting, value in pairs(settings) do
        vim.bo[setting] = value
      end
    end,
  })
end

-- Git Config
vim.api.nvim_create_autocmd('BufRead', {
  pattern = { 'gitconfig' },
  callback = function() vim.opt.filetype = 'gitconfig' end,
})

-- Cursorline only in active window - more efficient implementation
local cursor_group = vim.api.nvim_create_augroup('CursorLine', { clear = true })

-- Use a single callback function to set cursorline for better performance
local function set_cursorline(value)
  return function()
    vim.opt_local.cursorline = value
  end
end

vim.api.nvim_create_autocmd({ 'InsertLeave', 'WinEnter' }, {
  group = cursor_group,
  pattern = '*',
  callback = set_cursorline(true),
  desc = 'show cursor line only in active window',
})

vim.api.nvim_create_autocmd({ 'InsertEnter', 'WinLeave' }, {
  group = cursor_group,
  pattern = '*',
  callback = set_cursorline(false),
})
