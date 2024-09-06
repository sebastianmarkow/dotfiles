-- Markdown
vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = 'markdown',
    callback = function()
      vim.bo.textwidth = 80
      vim.bo.wrap = true
      vim.bo.spell = true
      vim.bo.spelllang = 'en_us'
    end
  }
)

-- Golang
vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = 'go',
    callback = function()
      vim.bo.expandtab = false
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
    end
  }
)

-- Python
vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = 'python',
    callback = function()
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 4
      vim.bo.tabstop = 4
      vim.bo.softtabstop = 4
    end
  }
)

-- Terraform/Terragrunt
vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = {'terraform', 'terragrunt'},
    callback = function()
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
    end
  }
)

-- Lua/Fish/Bash
vim.api.nvim_create_autocmd(
  'FileType', {
    pattern = {'lua', 'fish', 'bash'},
    callback = function()
      vim.bo.expandtab = true
      vim.bo.shiftwidth = 2
      vim.bo.tabstop = 2
      vim.bo.softtabstop = 2
    end
  }
)
