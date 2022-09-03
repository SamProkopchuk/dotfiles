local wezterm = require 'wezterm'

return {
  font = wezterm.font('Iosevka Curly Light'),
  default_cursor_style = 'BlinkingBar',
  cursor_blink_rate = 469,
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant', 
  color_scheme = 'carbonfox',
  adjust_window_size_when_changing_font_size = false,
}

