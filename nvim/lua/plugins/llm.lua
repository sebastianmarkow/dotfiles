return {
  {
    'olimorris/codecompanion.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      { 'github/copilot.vim', cmd = 'Copilot' },
    },
    cmd = { 'CodeCompanion', 'CodeCompanionChat' },
    config = true,
    opts = {
      display = {
        chat = {
          window = {
            layout = "horizontal",
            opts = {
              number = false,
            },
          },
        },
      },
      strategies = {
        chat = {
          adapter = "copilot",
        },
      },
      opts = {
        -- Set debug logging
        log_level = "DEBUG",
      },
    },
  }
}
