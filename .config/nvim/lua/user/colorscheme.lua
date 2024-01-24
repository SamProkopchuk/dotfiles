local colorscheme = "kanagawa"

require(colorscheme).setup({
    background = {
        dark = "dragon",
        light = "lotus"
    },
})

vim.cmd("colorscheme " .. colorscheme)

