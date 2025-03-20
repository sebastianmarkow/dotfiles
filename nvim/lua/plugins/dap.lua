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
        keys = {
          { '<leader>du', function() require('dapui').toggle({}) end, desc = 'Dap UI' },
        },
      },
    },
    priority = 500,
    ft = { 'go', 'python' },
    keys = {
      { '<leader>d',  '',                                                desc = '+Debug' },
      { '<leader>ds', function() require('dap').continue() end,          desc = 'Run' },
      { '<leader>dK', function() require('dap.ui.widgets').hover() end,  desc = 'Widgets' },
      { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Toggle Breakpoint' },
      { '<leader>dc', function() require('dap').run_to_cursor() end,     desc = 'Continue' },
      { '<leader>dt', function() require('dap').terminate() end,         desc = 'Terminate' },
    },
    opts = {
      nvim_dap_virtual_text = {
        commented = true,
      },
    },
    config = function(opts)
      local dap = require('dap')
      local dapui = require('dapui')

      dapui.setup()

      dap.listeners.after.event_initialized['dapui_config'] = function() dapui.open({}) end
      dap.listeners.before.event_terminated['dapui_config'] = function() dapui.close({}) end
      dap.listeners.before.event_exited['dapui_config'] = function() dapui.close({}) end

      require('nvim-dap-virtual-text').setup(opts.nvim_dap_virtual_text)
    end,
  },
  {
    'leoluz/nvim-dap-go',
    priority = 100,
    ft = { 'go' },
    config = true,
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'williamboman/mason.nvim',
    },
    priority = 100,
    ft = { 'python' },
    config = function()
      local debugpy_path = require('mason-registry').get_package('debugpy'):get_install_path()
      require('dap-python').setup(debugpy_path .. '/venv/bin/python')
    end,
  },
}
