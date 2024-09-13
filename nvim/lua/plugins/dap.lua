return {
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'leoluz/nvim-dap-go',
      'mfussenegger/nvim-dap',
      'mfussenegger/nvim-dap-python',
      'nvim-neotest/nvim-nio',
      'theHamsta/nvim-dap-virtual-text',
    },
    event = 'BufRead',
    ft = { 'go', 'python' },
    config = function()
      require('dapui').setup()
      require('nvim-dap-virtual-text').setup()
      require('dap-go').setup()
      require('dap-python').setup()
    end,
  },
}
