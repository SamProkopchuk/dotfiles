require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    -- Conform will run multiple formatters sequentially
    python = { "black", "isort" },
    -- Use a sub-list to run only the first available formatter
    javascript = { { "prettierd", "prettier" } },
  },
})
