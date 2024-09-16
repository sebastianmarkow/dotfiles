return {
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      {
        'rcarriga/nvim-dap-ui',
        dependencies = {
          'nvim-neotest/nvim-nio',
          'theHamsta/nvim-dap-virtual-text',
        },
        keys = {},
      },
    },
    ft = { 'go', 'python' },
    keys = {},
    opts = {
      nvim_dap_virtual_text = {
        commented = true,
      },
    },
    config = function(opts)
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function()
        dapui.open({})
      end
      dap.listeners.before.event_terminated['dapui_config'] = function()
        dapui.close({})
      end
      dap.listeners.before.event_exited['dapui_config'] = function()
        dapui.close({})
      end

      require('nvim-dap-virtual-text').setup(opts.nvim_dap_virtual_text)
    end,
  },
  {
    'leoluz/nvim-dap-go',
    ft = { 'go' },
    config = true,
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'williamboman/mason.nvim',
    },
    ft = { 'python' },
    config = function()
      local debugpy_path = require('mason-registry').get_package('debugpy'):get_install_path()
      require('dap-python').setup(debugpy_path .. '/venv/bin/python')
    end,
  },
}
