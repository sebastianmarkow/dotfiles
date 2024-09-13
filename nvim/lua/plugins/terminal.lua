return {
  'akinsho/toggleterm.nvim',
  version = '*',
  keys = { { '<leader>t', mode = 'n', ':lua require(\'toggleterm\').toggle()<CR>', desc = 'Toggle terminal' } },
  config = function()
    require('toggleterm').setup({
      size = 20,
      shade_filetypes = {},
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      persist_size = false,
      direction = 'float',
      close_on_exit = true,
      shell = vim.o.shell,
      float_opts = { border = 'rounded', winblend = 0, highlights = { border = 'Normal', background = 'Normal' } },
    })
  end,
}
