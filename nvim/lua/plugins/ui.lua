local icons = require('config.icons')

local open_neotree_in_git_root = function()
  local result = vim.system({ 'git', 'rev-parse', '--show-toplevel' }, { text = true }):wait()
  local dir_to_open
  if result.code == 0 then
    dir_to_open = result.stdout:gsub('\n', '')
  else
    dir_to_open = vim.fn.getcwd()
  end
  require('neo-tree.command').execute({ toggle = true, dir = dir_to_open, reveal = true })
end

return {
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        variant = 'moon',
        dim_inactive_windows = true,
        enable = { terminal = true, legacy_highlights = false, migrations = true },
        styles = { italic = false, bold = false, transparency = false },
        highlight_groups = {
          Comment = { italic = true },
          Keyword = { italic = true },
          Statement = { italic = true },
          Visual = { bg = 'highlight_high' },

          IndentLine = { fg = 'overlay', nocombine = true },
          IndentLineCurrent = { fg = 'subtle', nocombine = true },

          NeoTreeTabActive = { fg = 'base', bg = 'foam' },
          NeoTreeTabSeparatorInactive = { fg = 'base', bg = 'base' },
          NeoTreeTabSeparatorActive = { fg = 'foam', bg = 'base' },
        },
      })
      vim.cmd('colorscheme rose-pine-moon')

      local palette = require('rose-pine/palette')

      vim.api.nvim_create_autocmd({ 'WinEnter', 'BufEnter', 'FocusGained' }, {
        pattern = '*',
        callback = function()
          vim.cmd('hi Normal guibg=' .. palette.base) -- Active window background
        end,
      })

      vim.api.nvim_create_autocmd({ 'WinLeave', 'BufLeave', 'FocusLost' }, {
        pattern = '*',
        callback = function()
          vim.cmd('hi Normal guibg=' .. palette._nc) -- Inactive window background
        end,
      })
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'MunifTanjim/nui.nvim',
      { 'echasnovski/mini.icons', opts = {} },
    },
    cmd = 'Neotree',
    keys = {
      {
        '<leader>e',
        mode = 'n',
        open_neotree_in_git_root,
        desc = 'Open NeoTree explorer in git root dir',
      },
    },
    config = function()
      require('neo-tree').setup({
        close_if_last_window = true,
        enable_diagnostics = true,
        enable_git_status = true,
        popup_border_style = 'rounded',
        use_libuv_file_watcher = true,
        source_selector = {
          sources = { { source = 'filesystem' }, { source = 'buffers' }, { source = 'git_status' } },
          winbar = true,
          show_scrolled_off_parent_node = true,
          content_layout = 'center',
          tabs_layout = 'equal',
          separator = { right = '', left = '' },
        },
        sources = { 'filesystem', 'buffers', 'git_status' },
        filesystem = {
          filtered_items = {
            visible = false,
            hide_dotfiles = false,
            hide_gitignored = false,
            never_show = { '.DS_Store', 'thumbs.db' },
          },
          follow_current_file = { enabled = true, leave_dirs_open = true },
          group_empty_dirs = true,
        },
        buffers = {
          show_unloaded = true,
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
            expander_highlight = 'NeoTreeExpander',
          },
          icon = {
            provider = function(icon, node) -- setup a custom icon provider
              local text, hl
              local mini_icons = require('mini.icons')
              if node.type == 'file' then
                text, hl = mini_icons.get('file', node.name)
              elseif node.type == 'directory' then
                text, hl = mini_icons.get('directory', node.name)
                if node:is_expanded() then text = nil end
              end
              if text then icon.text = text end
              if hl then icon.highlight = hl end
            end,
          },
          modified = { symbol = icons.git.modified, highlight = 'NeoTreeModified' },
          name = { trailing_slash = false, use_git_status_colors = true, highlight = 'NeoTreeFileName' },
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
              conflict = icons.git.conflict,
            },
          },
        },
      })
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'rose-pine/neovim',
    },
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

      theme.normal.c.fg = palette.subtle
      theme.insert.c.fg = palette.subtle
      theme.visual.c.fg = palette.subtle
      theme.replace.c.fg = palette.subtle
      theme.command.c.fg = palette.subtle
      theme.inactive.c.fg = palette.subtle

      local config = {
        options = {
          theme = theme,
          section_separators = { right = '', left = '' },
          component_separators = { right = '', left = '' },
          globalstatus = true,
          disabled_filetypes = { -- Filetypes to disable lualine for.
            winbar = {
              'Lazy',
              'Outline',
              'codecompanion',
              'dap-repl',
              'dapui_breakpoints',
              'dapui_console',
              'dapui_scopes',
              'dapui_stacks',
              'dapui_watches',
              'git',
              'gitcommit',
              'help',
              'neo-tree',
              'quickfix',
            },
          },
        },
        extensions = {
          'lazy',
          'mason',
          'neo-tree',
          'nvim-dap-ui',
          'quickfix',
        },
        sections = {
          lualine_a = {
            { 'mode', icon = '' },
          },
          lualine_b = {
            { 'branch', icon = '' },
            { 'diff', colored = true },
            {
              'diagnostics',
              colored = true,
              symbols = {
                error = icons.diagnostics.error .. ' ',
                warn = icons.diagnostics.warn .. ' ',
                info = icons.diagnostics.info .. ' ',
                hint = icons.diagnostics.hint .. ' ',
              },
            },
          },
          lualine_c = {},
          lualine_x = {
            { 'filetype', icon_only = true },
          },
          lualine_y = {
            { 'searchcount' },
            { 'location' },
            { 'progress' },
          },
          lualine_z = {},
        },
        inactive_sections = {
          lualine_a = {},
          lualine_c = { { 'filename', file_status = true } },
          lualine_x = { { window_number } },
        },
        winbar = {
          lualine_a = { { 'filename', file_status = true, path = 1 } },
          lualine_b = { { 'navic' } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { { window_number } },
        },
        inactive_winbar = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { { 'filename', file_status = true, path = 1 } },
          lualine_x = { { window_number } },
          lualine_y = {},
        },
        tabline = {},
      }
      return config
    end,
  },
  {
    'j-hui/fidget.nvim',
    event = 'VeryLazy',
    opts = {
      notification = {
        override_vim_notify = true,
        window = {
          border = 'rounded',
        },
      },
    },
  },
  {
    'folke/which-key.nvim',
    dependencies = {
      'echasnovski/mini.icons',
    },
    event = 'VeryLazy',
    opts = {
      keys = {
        scroll_down = '<c-j>', -- binding to scroll down inside the popup
        scroll_up = '<c-k>', -- binding to scroll up inside the popup
      },
    },
    keys = {
      {
        '<leader>?',
        function() require('which-key').show({ global = false }) end,
        desc = 'Show keymaps',
      },
      -- Groups
      -- +Plugin
      { '<leader>p', '', desc = '+Plugin' },
      { '<leader>pl', ':Lazy<cr>', desc = 'Open Lazy' },
      { '<leader>pm', ':Mason<cr>', desc = 'Open Mason' },
    },
  },
}
