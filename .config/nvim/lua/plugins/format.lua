vim.api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format({ async = true, lsp_fallback = true, range = range })
end, { range = true })

return {
  {
    {
      "stevearc/conform.nvim",
      tag = "v5.8.0",
      lazy = true,
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        local conform = require("conform")

        conform.setup({
          formatters_by_ft = {
            lua = { "stylua" },
            python = { "isort", "black" },
            rust = { "rustfmt" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            cuda = { "clang_format" },
            proto = { "clang_format" },
            r = { "styler" },
            json = { "jq" },
          },
        })

        vim.keymap.set({ "n", "v" }, "<leader>mp", function()
          conform.format({
            lsp_fallback = true,
            async = false,
            timeout_ms = 1000,
          })
        end, { desc = "Format file or range (in visual mode)" })
      end,
    },
  },
}
