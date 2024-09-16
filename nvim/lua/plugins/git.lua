return {
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    keys = { { 'gn', ':Gitsigns next_hunk<CR>', noremap = true }, { 'gp', ':Gitsigns prev_hunk<CR>', noremap = true } },
    config = function()
      local gitsigns = require('gitsigns')
      gitsigns.setup({
        signs = {
          add = { text = '▐' },
          change = { text = '▐' },
          delete = { text = '▐' },
          topdelete = { text = '▐' },
          changedelete = { text = '▐' },
          untracked = { text = '▐' },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        numhl = false, -- Toggle with `:Gitsigns toggle_nunhl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        sign_priority = 6,
        watch_gitdir = { interval = 5000 },
        auto_attach = true,
        attach_to_untracked = false,
        preview_config = { border = 'rounded' },
      })
    end,
  },
  {
    'NeogitOrg/neogit',
    dependencies = { 'nvim-lua/plenary.nvim', 'sindrets/diffview.nvim', 'nvim-telescope/telescope.nvim' },
    cmd = 'Neogit',
    config = true,
  },
  {
    'rhysd/committia.vim',
    event = 'BufReadPre',
    config = function()
      vim.g.committia_open_only_vim_starting = 0
      vim.g.committia_hooks = vim.empty_dict()
    end,
  },
}
