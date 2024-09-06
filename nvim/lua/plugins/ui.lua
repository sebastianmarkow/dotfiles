local icons = require('config.icons')

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      local palette = require('rose-pine.palette')

      require('rose-pine').setup(
        {
          variant = 'moon',
          dim_inactive_windows = true,
          enable = {
            terminal = true,
            legacy_highlights = false,
            migrations = true
          },
          styles = {italic = false, bold = true, transparency = false},
          highlight_groups = {
            Comment = {italic = true},
            Keyword = {italic = true},
            Statement = {italic = true},
            Visual = {bg = palette.highlight_high},
            IlluminatedWordText = {bg = palette.highlight_mid},
            IlluminatedWordRead = {bg = palette.highlight_mid},
            IlluminatedWordWrite = {bg = palette.highlight_mid},
            NeoTreeModified = {fg = palette.gold}
          }
        }
      )

      vim.cmd('colorscheme rose-pine-moon')
    end
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {'nvim-lua/plenary.nvim', 'MunifTanjim/nui.nvim'},
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        mode = 'n',
        function()
          local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub(
                             '\n', ''
                           )
          local dir_to_open

          if vim.v.shell_error == 0 then
            dir_to_open = git_root
          else
            dir_to_open = vim.fn.getcwd()
          end

          require('neo-tree.command').execute(
            {toggle = true, dir = dir_to_open, reveal = true}
          )
        end,
        desc = 'Open NeoTree explorer in git root dir'
      }
    },
    config = function()
      require('neo-tree').setup(
        {
          close_if_last_window = true,
          enable_diagnostics = true,
          enable_git_status = true,
          popup_border_style = 'rounded',
          use_libuv_file_watcher = true,
          source_selector = {winbar = true},
          sources = {'filesystem', 'buffers', 'git_status'},
          filesystem = {
            filtered_items = {
              visible = false,
              hide_dotfiles = false,
              hide_gitignored = true,
              never_show = {'.DS_Store', 'thumbs.db'}
            },
            follow_current_file = {enabled = true, leave_dirs_open = true},
            group_empty_dirs = true
          },
          default_component_configs = {
            indent = {
              indent_size = 2,
              padding = 1,
              with_markers = true,
              indent_marker = '│',
              last_indent_marker = '└',
              highlight = 'NeoTreeIndentMarker',
              with_expanders = nil,
              expander_collapsed = '',
              expander_expanded = '',
              expander_highlight = 'NeoTreeExpander'
            },
            icon = {
              folder_closed = '󰉋',
              folder_open = '󰝰',
              folder_empty = '󰉖',
              default = '󰈔',
              highlight = 'NeoTreeFileIcon'
            },
            modified = {symbol = '', highlight = 'NeoTreeModified'},
            name = {
              trailing_slash = false,
              use_git_status_colors = true,
              highlight = 'NeoTreeFileName'
            },
            git_status = {
              symbols = {
                added = icons.git.added,
                modified = icons.git.modified,
                deleted = icons.git.deleted,
                renamed = icons.git.renamed,
                untracked = icons.git.untracked,
                ignored = icons.git.ignored,
                unstaged = icons.git.unstaged,
                staged = icons.git.staged,
                conflict = icons.git.conflict
              }
            }
          }
        }
      )
    end
  },
  {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
          vim.o.timeout = true
          vim.o.timeoutlen = 300
      end,
  },
}
