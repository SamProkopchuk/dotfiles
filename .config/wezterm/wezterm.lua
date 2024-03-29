local wezterm = require("wezterm")


local kanagawa_wave = {
    foreground = "#dcd7ba",
    background = "#1f1f28",
    cursor_bg = "#c8c093",
    cursor_fg = "#192330",
    cursor_border = "#c8c093",
    selection_fg = "#c8c093",
    selection_bg = "#2d4f67",
    scrollbar_thumb = "#16161d",
    split = "#16161d",
    ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
    brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
    indexed = { [16] = "#ffa066", [17] = "#ff5d62"}
}

return {
    font = wezterm.font("Iosevka Curly"),
    font_size = 16.0,
    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 469,
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    adjust_window_size_when_changing_font_size = false,
    warn_about_missing_glyphs = false,
	force_reverse_video_cursor = false,
	colors = kanagawa_wave,
    hide_tab_bar_if_only_one_tab = true,
}

