return {
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    config = function()
      local treesitter = require('nvim-treesitter.configs')
      treesitter.setup(
        {
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
            -- Disable for +100kb files
            disable = function(lang, buf)
              local max_filesize = 100 * 1024
              local ok, stats = pcall(
                                  vim.loop.fs_stat,
                                  vim.api.nvim_buf_get_name(buf)
                                )
              if ok and stats and stats.size > max_filesize then
                return true
              end
            end
          }
        }
      )

      vim.o.foldmethod = 'expr'
      vim.o.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
    build = ':TSUpdate'
  }
}
