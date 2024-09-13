return {
  {
    'epwalsh/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    ft = 'markdown',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    opts = {
      workspaces = {
        {
          name = 'Personal',
          path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Personal',
        },
        {
          name = 'Work',
          path = '~/Library/Mobile Documents/iCloud~md~obsidian/Documents/Work',
        },
      },
    },
  },
}
