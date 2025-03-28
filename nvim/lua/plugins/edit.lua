return {
  { 'numToStr/Comment.nvim', event = 'InsertEnter' },
  {
    'windwp/nvim-autopairs',
    dependencies = {
      'hrsh7th/nvim-cmp',
    },
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      enable_check_bracket_line = false,
      ignored_next_char = '[%w%.]',
    },
    config = function(opts)
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require('cmp')
      cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
      require('nvim-autopairs').setup(opts)
    end,
  },
  {
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    filetype = { 'python', 'go', 'rust', 'lua' },
    config = function()
      require('conform').setup({
        formatters_by_ft = {
          lua = { 'stylua' },
          go = { 'goimports', 'gofmt' },
          python = { 'isort', 'black' },
          rust = { 'rustfmt' },
        },
        default_format_opts = { lsp_format = 'fallback' },
        format_on_save = {
          lsp_format = 'fallback',
          timeout_ms = 500,
        },
      })
    end,
  },
}
