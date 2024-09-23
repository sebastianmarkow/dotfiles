return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'hrsh7th/nvim-cmp',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
      { 'github/copilot.vim', cmd = 'Copilot' },
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat', 'CodeCompanionToggle' },
    config = function()
      require('codecompanion').setup({
        strategies = {
          chat = {
            adapter = 'copilot',
          },
          inline = {
            adapter = 'copilot',
          },
          agent = {
            adapter = 'copilot',
          },
        },
        adapters = {
          copilot = function() return require('codecompanion.adapters').extend('copilot', {}) end,
        },
        display = {
          diff = {
            provider = 'mini_diff',
          },
        },
        opts = {
          log_level = 'DEBUG',
        },
      })
    end,
  },
}
