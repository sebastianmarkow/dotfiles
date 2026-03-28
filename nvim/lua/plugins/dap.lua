return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'rcarriga/nvim-dap-ui',
    'theHamsta/nvim-dap-virtual-text',
    'nvim-neotest/nvim-nio',
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',
  },
  ft = { 'go', 'python', 'rust' },
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
      '<leader>dL',
      function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log message: ')) end,
      desc = 'Debug: Log Breakpoint',
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
    {
      '<leader>dr',
      function() require('dap').repl.open() end,
      desc = 'Debug: Open REPL',
    },
    {
      '<leader>de',
      function() require('dapui').eval() end,
      desc = 'Debug: Evaluate Expression',
      mode = { 'n', 'v' },
    },
    {
      '<leader>dx',
      function() require('dap').terminate() end,
      desc = 'Debug: Terminate',
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

    require('nvim-dap-virtual-text').setup({
      commented = true,
    })

    -- Python
    local dappython = require('dap-python')
    dappython.setup('uv')
    dappython.test_runner = 'pytest'

    -- Go
    require('dap-go').setup()

    -- Rust (codelldb via Mason)
    local ok, registry = pcall(require, 'mason-registry')
    local codelldb_cmd = 'codelldb'
    if ok and registry.is_installed('codelldb') then
      local pkg = registry.get_package('codelldb')
      codelldb_cmd = pkg:get_install_path() .. '/extension/adapter/codelldb'
    end

    dap.adapters.codelldb = {
      type = 'server',
      port = '${port}',
      executable = {
        command = codelldb_cmd,
        args = { '--port', '${port}' },
      },
    }

    dap.configurations.rust = {
      {
        name = 'Launch binary',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
      {
        name = 'Launch binary (with args)',
        type = 'codelldb',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/', 'file')
        end,
        args = function()
          local args = vim.fn.input('Args: ')
          return vim.split(args, ' ', { trimempty = true })
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
      },
    }
  end,
}
