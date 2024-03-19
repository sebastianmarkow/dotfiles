local wezterm = require("wezterm")
local config = wezterm.config_builder()
local colors = require("themes/rose-pine-moon").colors()
local window_frame = require("themes/rose-pine-moon").window_frame()

wezterm.log_info("reloading")

config.default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "main" }
config.term = "wezterm"

config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

config.colors = colors
config.window_frame = window_frame

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 16
config.font_rules = {
    {
        intensity = "Bold",
        italic = false,
        font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Bold", style = "Normal" }),
    },
    {
        intensity = "Normal",
        italic = true,
        font = wezterm.font({ family = "JetBrainsMono Nerd Font", style = "Italic" }),
    },
    {
        intensity = "Bold",
        italic = true,
        font = wezterm.font({ family = "JetBrainsMono Nerd Font", weight = "Bold", style = "Italic" }),
    },
}

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.force_reverse_video_cursor = false

config.underline_thickness = 3
config.cursor_thickness = 4
config.underline_position = -6

config.enable_tab_bar = false

config.initial_rows = 48
config.initial_cols = 120

config.scrollback_lines = 10000

config.window_background_opacity = 1.0
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }

return config
