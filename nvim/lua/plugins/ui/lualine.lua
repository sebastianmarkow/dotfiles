return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function()
        local colors = {
            base03 = 0,
            base02 = 8,
            base01 = 10,
            base00 = 12,
            base0 = 11,
            base1 = 14,
            base2 = 7,
            base3 = 15,
            red = 1,
            orange = 9,
            yellow = 3,
            magenta = 13,
            violet = 5,
            blue = 4,
            cyan = 6,
            green = 2,
        }
        gotham_lualine = {
            normal = {
                a = { bg = colors.blue, fg = colors.base3 },
                b = { bg = colors.base01, fg = colors.base1 },
                c = { bg = colors.base02, fg = colors.base1 },
                z = { bg = colors.blue, fg = colors.base3 },
            },
            insert = {
                a = { bg = colors.green, fg = colors.base3 },
                b = { bg = colors.base01, fg = colors.base1 },
                c = { bg = colors.base02, fg = colors.base1 },
                z = { bg = colors.blue, fg = colors.base3 },
            },
            visual = {
                a = { bg = colors.violet, fg = colors.base3 },
                b = { bg = colors.base01, fg = colors.base1 },
                c = { bg = colors.base02, fg = colors.base1 },
                z = { bg = colors.blue, fg = colors.base3 },
            },
            replace = {
                a = { bg = colors.red, fg = colors.base3 },
                b = { bg = colors.base01, fg = colors.base1 },
                c = { bg = colors.base02, fg = colors.base1 },
                z = { bg = colors.blue, fg = colors.base3 },
            },
            command = {
                a = { bg = colors.violet, fg = colors.base3 },
                b = { bg = colors.base01, fg = colors.base1 },
                c = { bg = colors.base02, fg = colors.base1 },
                z = { bg = colors.blue, fg = colors.base3 },
            },
            inactive = {
                a = { bg = colors.base02, fg = colors.blue },
                b = { bg = colors.base01, fg = colors.base1 },
                c = { bg = colors.base02, fg = colors.base1 },
                z = { bg = colors.blue, fg = colors.base3 },
            },
        }
        local function window_number()
            return string.format("⧉ %d", vim.api.nvim_win_get_number(vim.api.nvim_get_current_win()))
        end
        local config = {
            options = {
                theme = gotham_lualine,
                always_divide_middle = true,
                icons_enabled = false,
                section_separators = "",
                component_separators = "|",
            },
            extensions = {},
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", { "diff", colored = false }, "diagnostics" },
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = { "filetype" },
                lualine_z = { "location", window_number },
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { "filename" },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { window_number },
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
                lualine_a = { { "buffers", mode = 4 } },
                lualine_b = {},
                lualine_c = {},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {},
            },
        }
        return config
    end,
}
