local icons = require("config.icons")

return {
    {
        "rose-pine/neovim",
        name = "rose-pine",
        lazy = false,
        priority = 1000,
        config = function()
            local palette = require("rose-pine.palette")

            require("rose-pine").setup({
                variant = "moon",
                dim_inactive_windows = true,
                 enable = {
                    terminal = true,
                    legacy_highlights = false,
                    migrations = true,
                },
                styles = {
                    italic = false,
                    bold = true,
                    transparency = false,
                },
                highlight_groups = {
                    Comment = { italic = true },
                    Keyword = { italic = true },
                    Statement = { italic = true },
                    Visual = { bg = palette.highlight_high },
                    IlluminatedWordText = { bg = palette.highlight_mid },
                    IlluminatedWordRead = { bg = palette.highlight_mid },
                    IlluminatedWordWrite = { bg = palette.highlight_mid },
                },
            })

            vim.cmd([[colorscheme rose-pine-moon]])
        end,
    },
    {
        "norcalli/nvim-colorizer.lua",
        event = { "BufRead" },
        ft = {
            "lua",
            "tmux",
            "toml",
            "yaml",
        },
        config = function()
            require("colorizer").setup({
                "lua",
                "tmux",
                "toml",
                "yaml",
                html = {
                    mode = "foreground",
                },
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
        },
        cmd = "Neotree",
        keys = {
            {
                "<leader>e",
                mode = "n",
                function()
                    local git_root = vim.fn.system("git rev-parse --show-toplevel"):gsub("\n", "")
                    local dir_to_open

                    if vim.v.shell_error == 0 then
                        dir_to_open = git_root
                    else
                        dir_to_open = vim.fn.getcwd()
                    end

                    require("neo-tree.command").execute({ toggle = true, dir = dir_to_open, reveal = true })
                end,
                desc = "Open NeoTree explorer in git root dir",
            },
        },
        config = function()
            require("neo-tree").setup({
                close_if_last_window = true,
                popup_border_style = "rounded",
                enable_git_status = true,
                enable_diagnostics = true,
                filesystem = {
                    filtered_items = {
                        visible = false,
                        hide_dotfiles = false,
                        hide_gitignored = true,
                        never_show = {
                            ".DS_Store",
                            "thumbs.db",
                        },
                    },
                    follow_current_file = {
                        enabled = true,
                        leave_dirs_open = true,
                    },
                },
                default_component_configs = {
                    container = {
                        enable_character_fade = true,
                    },
                    indent = {
                        indent_size = 2,
                        padding = 1,
                        with_markers = true,
                        indent_marker = "│",
                        last_indent_marker = "└",
                        highlight = "NeoTreeIndentMarker",
                        with_expanders = nil,
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                    icon = {
                        folder_closed = "󰉋",
                        folder_open = "󰝰",
                        folder_empty = "󰉖",
                        default = "󰈔",
                        highlight = "NeoTreeFileIcon",
                    },
                    modified = {
                        symbol = "",
                        highlight = "NeoTreeModified",
                    },
                    name = {
                        trailing_slash = false,
                        use_git_status_colors = true,
                        highlight = "NeoTreeFileName",
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
                            conflict = icons.git.conflict,
                        },
                    },
                },
            })
        end,
    },
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup()
        end,
    },
    {
        "lewis6991/satellite.nvim",
        lazy = false,
        config = function()
            require("satellite").setup({
                current_only = false,
                winblend = 50,
                zindex = 40,
                excluded_filetypes = {},
                width = 2,
                handlers = {
                    cursor = {
                        enable = true,
                        -- Supports any number of symbols
                        symbols = { "⎺", "⎻", "⎼", "⎽" },
                        -- symbols = { '⎻', '⎼' }
                        -- Highlights:
                        -- - SatelliteCursor (default links to NonText
                    },
                    search = {
                        enable = true,
                        -- Highlights:
                        -- - SatelliteSearch (default links to Search)
                        -- - SatelliteSearchCurrent (default links to SearchCurrent)
                    },
                    diagnostic = {
                        enable = true,
                        signs = { "-", "=", "≡" },
                        min_severity = vim.diagnostic.severity.HINT,
                        -- Highlights:
                        -- - SatelliteDiagnosticError (default links to DiagnosticError)
                        -- - SatelliteDiagnosticWarn (default links to DiagnosticWarn)
                        -- - SatelliteDiagnosticInfo (default links to DiagnosticInfo)
                        -- - SatelliteDiagnosticHint (default links to DiagnosticHint)
                    },
                    gitsigns = {
                        enable = true,
                        signs = { -- can only be a single character (multibyte is okay)
                            add = "│",
                            change = "│",
                            delete = "-",
                        },
                        -- Highlights:
                        -- SatelliteGitSignsAdd (default links to GitSignsAdd)
                        -- SatelliteGitSignsChange (default links to GitSignsChange)
                        -- SatelliteGitSignsDelete (default links to GitSignsDelete)
                    },
                    marks = {
                        enable = false,
                    },
                    quickfix = {
                        signs = { "-", "=", "≡" },
                    },
                },
            })
        end,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufRead" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
        },
        main = "ibl",
        opts = {
            indent = {
                char = "┊",
            },

            scope = {
                show_start = false,
                show_end = false,
            },
            exclude = {
                filetypes = {
                    "",
                    "neo-tree",
                    "checkhealth",
                    "gitcommit",
                    "help",
                    "help",
                    "lazy",
                    "lspinfo",
                    "man",
                    "mason",
                    "terminal",
                },
            },
        },
    },
    {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPost", "BufNewFile", "VeryLazy" },
        opts = function()
            local function window_number()
                return string.format(" %d", vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()))
            end
            local palette = require("rose-pine/palette")
            local theme = require("lualine/themes/rose-pine")
            theme.normal.a.bg = palette.iris
            theme.normal.b.fg = palette.iris
            theme.visual.a.bg = palette.rose
            theme.visual.b.fg = palette.rose

            local config = {
                options = {
                    theme = theme,
                    section_separators = { right = "", left = "" },
                    component_separators = { right = "", left = "" },
                    globalstatus = true,
                    disabled_filetypes = { -- Filetypes to disable lualine for.
                        winbar = {
                            "Lazy",
                            "help",
                            "neo-tree",
                            "neotest-summary",
                            "quickfix",
                            "qf"
                        }, -- only ignores the ft for winbar.
                        statusline = {
                            "Lazy",
                            "help",
                            "neo-tree",
                        }, -- only ignores the ft for winbar.
                    },
                },
                extensions = { "lazy", "mason", "fugitive", "neo-tree", "nvim-dap-ui", "toggleterm" },
                sections = {
                    lualine_a = { { "mode", icon = "" } },
                    lualine_b = {
                        { "branch", icon = "" },
                        { "diff", colored = true },
                    },
                    lualine_c = { { "filename", file_status = false } },
                    lualine_x = { { "filetype", icon_only = true } },
                    lualine_y = {
                        {
                            "diagnostics",
                            colored = true,
                            symbols = {
                                error = icons.diagnostics.Error .. " ",
                                warn = icons.diagnostics.Warn .. " ",
                                info = icons.diagnostics.Info .. " ",
                                hint = icons.diagnostics.Hint .. " ",
                            },
                        },
                        "location",
                    },
                    lualine_z = { window_number },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { { "filename", file_status = false } },
                    lualine_x = { window_number },
                    lualine_y = {},
                    lualine_z = {},
                },
                winbar = {
                    lualine_a = { { "buffers", mode = 2, filetype_names = { ["neotest-summary"] = "Neotest" } } },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                inactive_winbar = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { { "buffers", mode = 2 } },
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {},
                },
                tabline = {},
            }
            return config
        end,
    },
}
