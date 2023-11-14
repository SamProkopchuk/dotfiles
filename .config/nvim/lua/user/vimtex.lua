local status_ok, vimtex = pcall(require, "vimtex")
if not status_ok then return end

vimtex.setup()

vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.cmd('set conceallevel=1')
vim.g.tex_conceal = 'abdmg'

