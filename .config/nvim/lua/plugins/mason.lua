return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      mason = require("mason")
      mason.setup({
        ensure_installed = {
          pyright = {},
          clangd = {},
          r_language_server = {},
          lua_ls = {},
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
      vim.fn.sign_define("LspDiagnosticsSignError", { text = "", numhl = "LspDiagnosticsDefaultError" })
      vim.fn.sign_define("LspDiagnosticsSignWarning", { text = "", numhl = "LspDiagnosticsDefaultWarning" })
      vim.fn.sign_define("LspDiagnosticsSignInformation", { text = "", numhl = "LspDiagnosticsDefaultInformation" })
      vim.fn.sign_define("LspDiagnosticsSignHint", { text = "", numhl = "LspDiagnosticsDefaultHint" })
      -- vim.lsp.handlers["textDocument/publishDiagnostics"] = function() end
    end,
  },
}
