return {
  {
    'alexghergh/nvim-tmux-navigation',
    event = 'VeryLazy',
    keys = {
      { '<M-h>', '<Cmd>NvimTmuxNavigateLeft<CR>' },
      { '<M-j>', '<Cmd>NvimTmuxNavigateDown<CR>' },
      { '<M-k>', '<Cmd>NvimTmuxNavigateUp<CR>' },
      { '<M-l>', '<Cmd>NvimTmuxNavigateRight<CR>' },
    },
    config = function()
      require('nvim-tmux-navigation').setup({
        disable_when_zoomed = true,
      })
    end,
  },
}
