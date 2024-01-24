local wezterm = require("wezterm")

local kanagawa_dracula = {
	force_reverse_video_cursor = true,
	foreground = "#c5c9c5",
	background = "#181616",

	cursor_bg = "#C8C093",
	cursor_fg = "#C8C093",
	cursor_border = "#C8C093",

	selection_fg = "#C8C093",
	selection_bg = "#2D4F67",

	scrollbar_thumb = "#16161D",
	split = "#16161D",

	ansi = {
		"#0D0C0C",
		"#C4746E",
		"#8A9A7B",
		"#C4B28A",
		"#8BA4B0",
		"#A292A3",
		"#8EA4A2",
		"#C8C093",
	},
	brights = {
		"#A6A69C",
		"#E46876",
		"#87A987",
		"#E6C384",
		"#7FB4CA",
		"#938AA9",
		"#7AA89F",
		"#C5C9C5",
	},
	indexed = { [16] = "#B6927B", [17] = "#B98D7B" },
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
	force_reverse_video_cursor = true,
	colors = kanagawa_dracula,
}

