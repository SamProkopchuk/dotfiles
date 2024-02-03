return {{
    "lukas-reineke/indent-blankline.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require("ibl").setup()
    end,
}}

