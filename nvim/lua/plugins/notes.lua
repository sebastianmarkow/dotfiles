return {
  'zk-org/zk-nvim',
  dependencies = { 'folke/snacks.nvim' },
  event = { 'BufReadPre *.md', 'BufNewFile *.md' },
  keys = {
    { '<leader>n',  nil,                                                            desc = 'Notes/zk' },
    { '<leader>nn', '<cmd>ZkNew { title = vim.fn.input("Title: ") }<cr>',          desc = 'New note' },
    { '<leader>no', '<cmd>ZkNotes { sort = { "modified" } }<cr>',                  desc = 'Open notes' },
    { '<leader>nt', '<cmd>ZkTags<cr>',                                              desc = 'Browse tags' },
    { '<leader>nf', '<cmd>ZkNotes { sort = { "modified" }, match = { vim.fn.input("Search: ") } }<cr>', desc = 'Find notes' },
    { '<leader>nb', '<cmd>ZkBacklinks<cr>',                                         desc = 'Backlinks' },
    { '<leader>nl', '<cmd>ZkLinks<cr>',                                             desc = 'Links' },
    { '<leader>nf', ":'<,'>ZkMatch<cr>",                                            mode = 'v',         desc = 'Find matching notes' },
    { '<leader>nn', ":'<,'>ZkNewFromTitleSelection<cr>",                            mode = 'v',         desc = 'New note from selection' },
  },
  config = function()
    require('zk').setup({
      picker = 'snacks_picker',
      lsp = {
        config = {
          cmd = { 'zk', 'lsp' },
          name = 'zk',
        },
        auto_attach = {
          enabled = true,
          filetypes = { 'markdown' },
        },
      },
    })
  end,
}
