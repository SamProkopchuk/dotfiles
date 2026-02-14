return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      local mason = require("mason")
      mason.setup({
        ensure_installed = {
          "basedpyright",
          "clangd",
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
      -- Configure basedpyright
      vim.lsp.config.basedpyright = {
        default_config = {
          cmd = { "basedpyright-langserver", "--stdio" },
          filetypes = { "python" },
          root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", ".git" },
          single_file_support = true,
        },
      }

      -- Configure clangd
      vim.lsp.config.clangd = {
        default_config = {
          cmd = { "clangd" },
          filetypes = { "c", "cpp", "h", "hpp", "cc" },
          root_markers = {
            ".clangd",
            ".clang-tidy",
            ".clang-format",
            "compile_commands.json",
            "compile_flags.txt",
            ".git",
          },
          single_file_support = true,
        },
      }

      -- Enable the language servers
      vim.lsp.enable("basedpyright")
      vim.lsp.enable("clangd")
    end,
  },
}
