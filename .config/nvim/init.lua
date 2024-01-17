require("user.options")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("user.plugins")

require("user.colorscheme")
require("user.neoscroll")
require("user.nvim-tree")
require("user.treesitter")
require("user.lspconfig")
require("user.bufferline")
require("user.toggleterm")
require("user.indent-blankline")
require("user.copilot")
require("user.vimtex")
require("user.conform")
require("user.clangd_extensions")

require("user.keymaps")
