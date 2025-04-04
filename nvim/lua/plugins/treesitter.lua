return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = { 'theHamsta/nvim-treesitter-pairs' },
    lazy = false,
    config = function()
      require('nvim-treesitter.configs').setup({
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
          -- Disable for +100kb files
          disable = function(_, buf)
            local max_filesize = 100 * 1024
            local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then return true end
          end,
        },
        pairs = {
          enable = true,
          disable = {},
          highlight_pair_events = {},
          highlight_self = false,
          goto_right_end = false,
          fallback_cmd_normal = 'call matchit#Match_wrapper(\'\',1,\'n\')',
          keymaps = { goto_partner = '<leader>%', delete_balanced = 'X' },
          delete_balanced = { only_on_first_char = false, fallback_cmd_normal = nil, longest_partner = false },
        },
      })

      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
    build = {
      ':TSUpdate',
      ':TSInstall! bash',
      ':TSInstall! diff',
      ':TSInstall! dockerfile',
      ':TSInstall! fish',
      ':TSInstall! git_config',
      ':TSInstall! gitattributes',
      ':TSInstall! gitcommit',
      ':TSInstall! gitignore',
      ':TSInstall! go',
      ':TSInstall! gomod',
      ':TSInstall! gosum',
      ':TSInstall! gotmpl',
      ':TSInstall! hcl',
      ':TSInstall! http',
      ':TSInstall! json',
      ':TSInstall! lua',
      ':TSInstall! luadoc',
      ':TSInstall! make',
      ':TSInstall! markdown',
      ':TSInstall! mermaid',
      ':TSInstall! proto',
      ':TSInstall! python',
      ':TSInstall! rst',
      ':TSInstall! rust',
      ':TSInstall! sql',
      ':TSInstall! terraform',
      ':TSInstall! tmux',
      ':TSInstall! toml',
      ':TSInstall! yaml',
    },
  },
}
