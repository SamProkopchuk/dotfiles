return {{
    "rebelot/kanagawa.nvim",
    lazy = false,
    config = function()
        require("kanagawa").setup({
            background = {
                dark = "wave",
                light = "lotus"
            },
        })
        vim.cmd("colorscheme " .. "kanagawa")
    end,
}}

