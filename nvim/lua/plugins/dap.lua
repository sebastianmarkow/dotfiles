return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  ft = { 'go', 'python' },
  keys = {
    {
      '<leader>dc',
      function() require('dap').continue() end,
      desc = 'Debug: Start/Continue',
    },
    {
      '<leader>di',
      function() require('dap').step_into() end,
      desc = 'Debug: Step Into',
    },
    {
      '<leader>dv',
      function() require('dap').step_over() end,
      desc = 'Debug: Step Over',
    },
    {
      '<leader>do',
      function() require('dap').step_out() end,
      desc = 'Debug: Step Out',
    },
    {
      '<leader>db',
      function() require('dap').toggle_breakpoint() end,
      desc = 'Debug: Toggle Breakpoint',
    },
    {
      '<leader>dB',
      function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,
      desc = 'Debug: Set Conditional Breakpoint',
    },
    {
      '<leader>dt',
      function() require('dapui').toggle() end,
      desc = 'Debug: Toggle UI',
    },
    {
      '<leader>dl',
      function() require('dap').run_last() end,
      desc = 'Debug: Run Last Configuration',
    },
  },
  config = function()
    local dap = require('dap')
    local dapui = require('dapui')

    dapui.setup({
      icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
      controls = {
        icons = {
          pause = '⏸',
          play = '▶',
          step_into = '⏎',
          step_over = '⏭',
          step_out = '⏮',
          step_back = 'b',
          run_last = '▶▶',
          terminate = '⏹',
          disconnect = '⏏',
        },
      },
    })

    dap.listeners.after.event_initialized['dapui_config'] = dapui.open
    dap.listeners.before.event_terminated['dapui_config'] = dapui.close
    dap.listeners.before.event_exited['dapui_config'] = dapui.close

    require('nvim-dap-virtual-text').setup()

    local dappython = require('dap-python')
    dappython.setup('uv')
    dappython.test_runner = 'pytest'
  end,
}
