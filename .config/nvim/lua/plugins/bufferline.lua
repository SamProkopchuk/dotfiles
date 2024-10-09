return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("bufferline").setup({
        options = {
          close_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          right_mouse_command = function(n)
            require("mini.bufremove").delete(n, false)
          end,
          diagnostics = "nvim_lsp",
          always_show_bufferline = false,
          offsets = {
            {
              filetype = "NvimTree",
              text = "Explorer",
              highlight = "PanelHeading",
              padding = 1,
            },
          },
        },
      })
    end,
  },
}
