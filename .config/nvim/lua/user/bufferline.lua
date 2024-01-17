local bufferline = require("bufferline")

bufferline.setup({
  options = {
    -- stylua: ignore
    close_command = function(n) require("mini.bufremove").delete(n, false) end,
    -- stylua: ignore
    right_mouse_command = function(n) require("mini.bufremove").delete(n, false) end,
    diagnostics = "nvim_lsp",
    always_show_bufferline = false,
    diagnostics_indicator = function(_, _, diag)
      local icons = require("lazyvim.config").icons.diagnostics
      local ret = (diag.error and icons.Error .. diag.error .. " " or "")
        .. (diag.warning and icons.Warn .. diag.warning or "")
      return vim.trim(ret)
    end,
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

