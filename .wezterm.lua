local wezterm = require("wezterm")

return {
    font = wezterm.font("Iosevka Curly"),
    font_size = 16.0,
    default_cursor_style = "BlinkingBar",
    cursor_blink_rate = 469,
    cursor_blink_ease_in = "Constant",
    cursor_blink_ease_out = "Constant",
    color_scheme = "gooey (Gogh)",
    adjust_window_size_when_changing_font_size = false,
    warn_about_missing_glyphs = false,
    colors = {
        -- The default text color
        foreground = "#ecf0c1",
        -- The default background color
        background = "#0f111b",

        -- Overrides the cell background color when the current cell is occupied by the
        -- cursor and the cursor style is set to Block
        cursor_bg = "#ecf0c1",
        -- Overrides the text color when the current cell is occupied by the cursor
        cursor_fg = "#000000",
        -- Specifies the border color of the cursor when the cursor style is set to Block,
        -- or the color of the vertical or horizontal bar when the cursor style is set to
        -- Bar or Underline.
        cursor_border = "#52ad70",

        -- the foreground color of selected text
        selection_fg = "#ffffff",
        -- the background color of selected text
        selection_bg = "#686f9a",

        -- The color of the scrollbar "thumb"; the portion that represents the current viewport
        scrollbar_thumb = "#222222",

        -- The color of the split lines between panes
        split = "#444444",

        ansi = {
            "#000000", "#e33400", "#5ccc96", "#b3a1e6", "#00a3cc", "#f2ce00",
            "#7a5ccc", "#686f9a"
        },
        brights = {
            "#686f9a", "#e33400", "#5ccc96", "#b3a1e6", "#00a3cc", "#f2ce00",
            "#7a5ccc", "#f0f1ce"
        },

        -- Arbitrary colors of the palette in the range from 16 to 255
        -- indexed = {[136] = "#af8700"},

        -- Since: 20220319-142410-0fcdea07
        -- When the IME, a dead key or a leader key are being processed and are effectively
        -- holding input pending the result of input composition, change the cursor
        -- to this color to give a visual cue about the compose state.
        compose_cursor = "orange",

        -- Colors for copy_mode and quick_select
        -- available since: 20220807-113146-c2fee766
        -- In copy_mode, the color of the active text is:
        -- 1. copy_mode_active_highlight_* if additional text was selected using the mouse
        -- 2. selection_* otherwise
        copy_mode_active_highlight_bg = {Color = "#000000"},
        -- use `AnsiColor` to specify one of the ansi color palette values
        -- (index 0-15) using one of the names "Black", "Maroon", "Green",
        --  "Olive", "Navy", "Purple", "Teal", "Silver", "Grey", "Red", "Lime",
        -- "Yellow", "Blue", "Fuchsia", "Aqua" or "White".
        copy_mode_active_highlight_fg = {AnsiColor = "Black"},
        copy_mode_inactive_highlight_bg = {Color = "#52ad70"},
        copy_mode_inactive_highlight_fg = {AnsiColor = "White"},

        quick_select_label_bg = {Color = "peru"},
        quick_select_label_fg = {Color = "#ffffff"},
        quick_select_match_bg = {AnsiColor = "Navy"},
        quick_select_match_fg = {Color = "#ffffff"}
    }
}

