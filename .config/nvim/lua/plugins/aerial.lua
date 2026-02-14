return {
  {
    "stevearc/aerial.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("aerial").setup({
        on_attach = function(bufnr)
          vim.keymap.set("n", "[f", "<cmd>AerialPrev<CR>", { buffer = bufnr })
          vim.keymap.set("n", "]f", "<cmd>AerialNext<CR>", { buffer = bufnr })
        end,
      })
    end,
  },
}
