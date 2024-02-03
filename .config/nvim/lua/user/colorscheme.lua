local colorscheme = "kanagawa"

require(colorscheme).setup({
    background = {
        dark = "wave",
        light = "lotus"
    },
})

vim.cmd("colorscheme " .. colorscheme)

