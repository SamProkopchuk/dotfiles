return {{
    "lervag/vimtex",
    lazy = true,
    config = function()
      require("vimtex").setup({
        compiler = {
          engine = "xelatex",
          options = "-file-line-error -synctex=1 -interaction=nonstopmode",
        },
        viewer = {
          program = "zathura",
          options = { "--fork", "%p" },
        },
        fold = {
          enable = false,
        },
        latex = {
          forwardSearch = {
            executable = "zathura",
            args = { "--synctex-forward", "%l:1:%f", "%p" },
          },
        },
        syntax = {
          items = {
            { pattern = "\\[a-zA-Z]+", error = true },
            { pattern = "\\(\\|\\)", error = true },
            { pattern = "\\[\\|\\]", error = true },
            { pattern = "\\{\\|\\}", error = true },
          },
        },
      })
    end,
}}

