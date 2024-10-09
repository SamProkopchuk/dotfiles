return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = "all", -- one of "all", or a list of languages
        sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
        ignore_install = { "phpdoc", "tree-sitter-phpdoc" }, -- List of parsers to ignore installing
        auto_install = false,
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "phpdoc", "tree-sitter-phpdoc" }, -- list of language that will be disabled
          additional_vim_regex_highlighting = false,
        },
        rainbow = {
          enable = true,
          -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
          extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
          max_file_lines = nil, -- Do not enable for files with more than n lines, int
          -- colors = {}, -- table of hex strings
          -- termcolors = {} -- table of colour name strings
        },
        -- indent = {enable = false, disable = {"yaml", "python"}},
        context_commentstring = { enable = true, enable_autocmd = false },
      })
    end,
  },
}
