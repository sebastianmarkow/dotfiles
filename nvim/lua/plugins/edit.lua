return {
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
    },
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPre', 'BufWritePre' },
    cmd = { 'ConformInfo' },
    ft = { 'python', 'go', 'lua', 'yaml' },
    keys = {
      {
        '<leader>cf',
        function()
          require('conform').format({ async = true }, function(err, did_edit)
            if not err and did_edit then vim.notify('Code formatted', vim.log.levels.INFO, { title = 'Conform' }) end
          end)
        end,
        mode = { 'n', 'v' },
        desc = 'Format buffer',
      },
    },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofmt' },
          python = { 'isort', 'ruff' },
          yaml = { 'yamlfmt' },
        },
        format_on_save = {
          lsp_format = 'fallback',
          timeout_ms = 500,
        },
      })
    end,
  },
}
