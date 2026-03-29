return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter').setup()

      require('nvim-treesitter').install({
        'bash',
        'diff',
        'dockerfile',
        'fish',
        'git_config',
        'gitattributes',
        'gitcommit',
        'gitignore',
        'go',
        'gomod',
        'gosum',
        'gotmpl',
        'hcl',
        'http',
        'json',
        'latex',
        'lua',
        'luadoc',
        'make',
        'markdown',
        'markdown_inline',
        'mermaid',
        'proto',
        'python',
        'rst',
        'rust',
        'sql',
        'terraform',
        'tmux',
        'toml',
        'yaml',
      })

      -- Disable treesitter highlighting for files >100KB
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
          if ok and stats and stats.size > 100 * 1024 then return end
          pcall(vim.treesitter.start, args.buf)
        end,
      })
    end,
  },
}
