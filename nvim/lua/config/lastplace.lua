vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = '*',
  callback = function()
    if vim.bo.filetype == 'gitcommit' then
      return
    end

    local last_pos = vim.fn.line('\'"')
    if last_pos > 0 and last_pos <= vim.fn.line('$') then
      vim.cmd('normal! g`"')
    end
  end,
})
