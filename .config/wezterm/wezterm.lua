local wezterm = require("wezterm")

local gruvbox_material_dark_hard = {
	foreground = "#d4be98",
	background = "#1d2021",
	cursor_bg = "#ddc7a1",
	cursor_fg = "#1d2021",
	cursor_border = "#ddc7a1",
	selection_fg = "#d4be98",
	selection_bg = "#3c3836",
	scrollbar_thumb = "#282828",
	split = "#282828",
	ansi = { "#141617", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#ddc7a1" },
	brights = { "#504945", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
	indexed = { [16] = "#e78a4e", [17] = "#e78a4e" },
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
	colors = gruvbox_material_dark_hard,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	enable_scroll_bar = false,
	hide_tab_bar_if_only_one_tab = true,
}
