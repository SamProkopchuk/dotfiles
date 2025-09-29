return {
   {
     "nvim-treesitter/nvim-treesitter",
     branch = "main",
     lazy = false,
     config = function()
       require("nvim-treesitter.config").setup({  -- Changed from .configs to .config
         ensure_installed = "all",
         sync_install = false,
         ignore_install = { "phpdoc", "tree-sitter-phpdoc" },
         auto_install = false,
         highlight = {
           enable = true,
           disable = { "phpdoc", "tree-sitter-phpdoc" },
           additional_vim_regex_highlighting = false,
         },
         rainbow = {
           enable = true,
           extended_mode = true,
           max_file_lines = nil,
         },
         context_commentstring = { enable = true, enable_autocmd = false },
       })
     end,
   },
 }
