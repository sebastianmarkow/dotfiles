local icons = require('config.icons')

return {
  {
    'nvim-neotest/neotest',
    dependencies = {
      'antoinemadec/FixCursorHold.nvim',
      'nvim-lua/plenary.nvim',
      'nvim-neotest/nvim-nio',
      'nvim-treesitter/nvim-treesitter',
      'nvim-neotest/neotest-go',
      'nvim-neotest/neotest-python'
    },
    ft = {'go', 'python'},
    config = function()
      require('neotest').setup(
        {
          icons = {running_animated = icons.animated.spinner, passed = 'v'},
          discovery = {enabled = true},
          diagnostic = {enabled = true},
          floating = {border = 'rounded'},
          quickfix = {enabled = false, open = true},
          adapters = {require('neotest-go'), require('neotest-python')}
        }
      )
    end
  }
}
