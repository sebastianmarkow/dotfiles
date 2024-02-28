return {
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
                section_separators = { right = "", left = ""},
                component_separators = { right = "", left = ""},
                globalstatus = true,
                disabled_filetypes = {     -- Filetypes to disable lualine for.
                    winbar = {
                        "Lazy",
                        "help",
                        "neo-tree",
                    },           -- only ignores the ft for winbar.
                    statusline = {
                        "Lazy",
                        "help",
                        "neo-tree",
                    },           -- only ignores the ft for winbar.
                },
            },
            extensions = { "lazy", "mason", "fugitive", "neo-tree" },
            sections = {
                lualine_a = { { "mode", icon = "" } },
                lualine_b = { { "branch", icon = "" }, { "diff", colored = false }, "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = { { "filetype", icon_only = true } },
                lualine_y = { "location" },
                lualine_z = { window_number },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = { window_number },
                lualine_y = {},
                lualine_z = {},
            },
            winbar = {
                lualine_a = { { "buffers", mode = 4 } },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            inactive_winbar = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "buffers", mode = 4 } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
            tabline = {},
        }
        return config
    end,
}
