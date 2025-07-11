return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      mason = require("mason")
      mason.setup({
        ensure_installed = {
          basedpyright = {},
          clangd = {},
        },
        automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
        ui = {
          icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    tag = "v1.32.0",
    opts = {},
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    after = "mason-lspconfig.nvim",
    config = function()
      lspconfig = require("lspconfig")
      lspconfig.basedpyright.setup({
        filetypes = { "python" },
      })
      lspconfig.clangd.setup({
        filetypes = { "c", "cpp", "h", "hpp", "cc" },
      })
    end,
  },
}
