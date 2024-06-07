local wezterm = require("wezterm")

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
  color_scheme = "GruvboxDarkHard",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  enable_scroll_bar = false,
  hide_tab_bar_if_only_one_tab = true,
}

