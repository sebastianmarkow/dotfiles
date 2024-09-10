local icons = require('config.icons')

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup(
        {
          variant = 'moon',
          dim_inactive_windows = true,
          enable = {terminal = true, legacy_highlights = false, migrations = true},
          styles = {italic = false, bold = true, transparency = false},
          highlight_groups = {
            Comment = {italic = true},
            Keyword = {italic = true},
            Statement = {italic = true},
            Visual = {bg = 'highlight_high'},

            IndentLine = {fg = 'overlay', nocombine = true},
            IndentLineCurrent = {fg = 'subtle', nocombine = true},

            IlluminatedWordText = {bg = 'highlight_mid'},
            IlluminatedWordRead = {bg = 'highlight_mid'},
            IlluminatedWordWrite = {bg = 'highlight_mid'},

            NeoTreeFileIcon = {fg = 'iris'},
            NeoTreeModified = {fg = 'gold'},
            NeoTreeTabActive = {fg = 'base', bg = 'iris'},
            NeoTreeTabSeparatorInactive = {fg = 'base', bg = 'base'},
            NeoTreeTabSeparatorActive = {fg = 'iris', bg = 'base'}
          }
        }
      )
      vim.cmd('colorscheme rose-pine-moon')
    end
  },
  {
    'hedyhli/outline.nvim',
    cmd = 'Outline',
    keys = {{'<leader>o', '<cmd>Outline<CR>', mode = 'n', desc = 'Open Outline explorer'}},
    config = true
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
          local git_root = vim.fn.system('git rev-parse --show-toplevel'):gsub('\n', '')
          local dir_to_open

          if vim.v.shell_error == 0 then
            dir_to_open = git_root
          else
            dir_to_open = vim.fn.getcwd()
          end

          require('neo-tree.command').execute({toggle = true, dir = dir_to_open, reveal = true})
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
          source_selector = {
            sources = {{source = 'filesystem'}, {source = 'git_status'}, {source = 'buffers'}},
            winbar = true,
            show_scrolled_off_parent_node = true,
            content_layout = 'center',
            tabs_layout = 'equal',
            separator = {right = '', left = ''}
          },
          sources = {'filesystem', 'git_status', 'buffers'},
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
              folder_closed = icons.neotree.folder_closed,
              folder_open = icons.neotree.folder_open,
              folder_empty = icons.neotree.folder_empty,
              default = icons.neotree.default,
              highlight = 'NeoTreeFileIcon'
            },
            modified = {symbol = icons.git.modified, highlight = 'NeoTreeModified'},
            name = {trailing_slash = false, use_git_status_colors = true, highlight = 'NeoTreeFileName'},
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
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function()
      local function window_number()
        return string.format(' %d', vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()))
      end

      local palette = require('rose-pine/palette')
      local theme = require('lualine/themes/rose-pine')
      theme.normal.a.bg = palette.iris
      theme.normal.b.fg = palette.iris
      theme.visual.a.bg = palette.rose
      theme.visual.b.fg = palette.rose

      local config = {
        options = {
          theme = theme,
          section_separators = {right = '', left = ''},
          component_separators = {right = '', left = ''},
          globalstatus = true,
          disabled_filetypes = { -- Filetypes to disable lualine for.
            winbar = {'Lazy', 'help', 'neo-tree', 'neotest-summary', 'quickfix', 'git', 'gitcommit'}
          }
        },
        extensions = {'lazy', 'mason', 'fugitive', 'neo-tree', 'nvim-dap-ui', 'toggleterm', 'quickfix'},
        sections = {
          lualine_a = {{'mode', icon = ''}},
          lualine_b = {{'branch', icon = ''}, {'diff', colored = true}},
          lualine_c = {{'filename', file_status = false}},
          lualine_x = {{'filetype', icon_only = true}},
          lualine_y = {
            {
              'diagnostics',
              colored = true,
              symbols = {
                error = icons.diagnostics.error .. ' ',
                warn = icons.diagnostics.warn .. ' ',
                info = icons.diagnostics.info .. ' ',
                hint = icons.diagnostics.hint .. ' '
              }
            },
            'location'
          },
          lualine_z = {window_number}
        },
        inactive_sections = {
          lualine_a = {},
          lualine_c = {{'filename', file_status = false}},
          lualine_x = {window_number}
        },
        winbar = {lualine_a = {{'buffers', mode = 2}}, lualine_c = {}, lualine_x = {}},
        inactive_winbar = {lualine_a = {}, lualine_c = {{'buffers', mode = 2}}, lualine_x = {}},
        tabline = {}
      }
      return config
    end
  },
  {
    'lewis6991/satellite.nvim',
    event = 'VeryLazy',
    config = function()
      require('satellite').setup(
        {
          current_only = true,
          winblend = 0,
          zindex = 40,
          excluded_filetypes = {'Lazy', 'help', 'neo-tree', 'neotest-summary', 'quickfix', 'qf'},
          width = 2,
          handlers = {
            cursor = {enable = true, symbols = {'⎺', '⎻', '⎼', '⎽'}},
            search = {enable = true},
            diagnostic = {enable = true, signs = {'-', '=', '≡'}, min_severity = vim.diagnostic.severity.HINT},
            gitsigns = {enable = true, signs = {add = '│', change = '│', delete = '-'}},
            marks = {enable = false},
            quickfix = {signs = {'-', '=', '≡'}}
          }
        }
      )
    end
  },
  {
    'nvimdev/indentmini.nvim',
    event = {'BufRead'},
    config = function()
      require('indentmini').setup({char = '┊'})
    end
  },
  {'nvim-telescope/telescope.nvim', branch = '0.1.x', dependencies = {'burntsushi/ripgrep', 'nvim-lua/plenary.nvim'}},
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      keys = {
        scroll_down = '<c-j>', -- binding to scroll down inside the popup
        scroll_up = '<c-k>' -- binding to scroll up inside the popup
      }
    },
    keys = {
      {
        '<leader>?',
        function()
          require('which-key').show({global = false})
        end,
        desc = 'Buffer Local Keymaps (which-key)'
      }
    }
  }
}
