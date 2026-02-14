return {
  {
    "lervag/vimtex",
    version = "*",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Copied from https://github.com/benbrastmckie/.config/blob/e32069991739b802419b2446ecfb1c796fa4d5b0/nvim/lua/neotex/plugins/vimtex.lua
      if vim.fn.has("mac") == 1 then
        vim.g["vimtex_view_method"] = "skim"
        vim.g["vimtex_context_pdf_viewer"] = "skim"
      else
        vim.g["vimtex_view_method"] = "zathura_simple" -- for variant without xdotool to avoid errors in wayland
        vim.g["vimtex_context_pdf_viewer"] = "okular" -- external PDF viewer run from vimtex menu command
      end
      vim.g["vimtex_quickfix_mode"] = 0 -- suppress error reporting on save and build
      vim.g["vimtex_mappings_enabled"] = 0 -- Ignore mappings
      vim.g["vimtex_indent_enabled"] = 0 -- Auto Indent
      vim.g["tex_flavor"] = "latex" -- how to read tex files
      vim.g["tex_indent_items"] = 0 -- turn off enumerate indent
      vim.g["tex_indent_brace"] = 0 -- turn off brace indent
      vim.g["vimtex_syntax_enabled"] = 1 -- Syntax highlighting
      vim.g["vimtex_log_ignore"] = { -- Error suppression:
        "Underfull",
        "Overfull",
        "specifier changed to",
        "Token not allowed in a PDF string",
      }
    end,
  },
}
