return {{
  "akinsho/toggleterm.nvim",
  version = "*",
  lazy = true,
  event = "BufWinEnter",
  config = function()
    require("toggleterm").setup {
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      terminal_mappings = true, -- whether or not the open mapping applies in the opened terminals
      persist_size = true,
      persist_mode = true, -- if set to true (default) the previous terminal mode will be remembered
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      float_opts = {border = "curved", winblend = 0}
    }
  end,
}}

