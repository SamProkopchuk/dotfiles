return {
  {
    "sainnhe/gruvbox-material",
    name = "gruvbox-material",
    lazy = false,
    config = function()
      vim.g.gruvbox_material_background = "hard"
      vim.cmd("colorscheme " .. "gruvbox-material")
    end,
  },
}
