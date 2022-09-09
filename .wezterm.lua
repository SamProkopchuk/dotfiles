local wezterm = require("wezterm")

return {
    font = wezterm.font("Iosevka Curly Semibold"),
    font_size = 16.0,
    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 469,
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    color_scheme = "Gruvbox Dark",
    adjust_window_size_when_changing_font_size = false,
    warn_about_missing_glyphs = false
}

