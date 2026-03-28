return {
  'zk-org/zk-nvim',
  dependencies = { 'folke/snacks.nvim' },
  event = { 'BufReadPre *.md', 'BufNewFile *.md' },
  keys = {
    { '<leader>n',  nil,                                                                                   desc = 'Notes/zk' },
    { '<leader>nn', '<cmd>ZkNew { title = vim.fn.input("Title: ") }<cr>',                                 desc = 'New note' },
    { '<leader>nc', '<cmd>ZkNew { group = "fleeting", title = vim.fn.input("Capture: ") }<cr>',           desc = 'Capture (fleeting)' },
    { '<leader>nj', '<cmd>ZkNew { group = "journal" }<cr>',                                               desc = 'Journal entry' },
    { '<leader>no', '<cmd>ZkNotes { sort = { "modified" } }<cr>',                                         desc = 'Open notes' },
    { '<leader>nt', '<cmd>ZkTags<cr>',                                                                    desc = 'Browse tags' },
    { '<leader>nf', '<cmd>ZkNotes { sort = { "modified" }, match = { vim.fn.input("Search: ") } }<cr>',  desc = 'Find notes' },
    { '<leader>nb', '<cmd>ZkBacklinks<cr>',                                                               desc = 'Backlinks' },
    { '<leader>nl', '<cmd>ZkLinks<cr>',                                                                   desc = 'Links' },
    { '<leader>nr', '<cmd>ZkNotes { createdAfter = "last two weeks", sort = { "created" } }<cr>',         desc = 'Recent notes' },
    { '<leader>ni', '<cmd>ZkNotes { hrefs = { "inbox" } }<cr>',                                           desc = 'Inbox (fleeting)' },
    -- Visual: create note from selection or search for matching notes
    { '<leader>nn', ":'<,'>ZkNewFromTitleSelection { group = 'fleeting' }<cr>",                           mode = 'v', desc = 'New note from selection' },
    { '<leader>nf', ":'<,'>ZkMatch<cr>",                                                                  mode = 'v', desc = 'Find matching notes' },
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

    -- Buffer-local keymaps that only make sense inside a zk notebook
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      desc = 'zk buffer-local keymaps',
      callback = function(ev)
        if not require('zk.util').notebook_root(vim.fn.expand('%:p')) then
          return
        end
        local opts = { buffer = ev.buf, silent = true }
        -- Follow wiki-link or jump to definition
        vim.keymap.set('n', '<CR>', vim.lsp.buf.definition, opts)
        -- Hover preview of linked note
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- Rename note title (updates all backlinks via LSP)
        vim.keymap.set('n', '<leader>nr', vim.lsp.buf.rename, opts)
      end,
    })
  end,
}
