local colorscheme = "onenord"

vim.g.onenord_style = "day"

-- vim.o.background = "light"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end

