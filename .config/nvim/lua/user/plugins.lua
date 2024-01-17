local plugins = {
    {"stevearc/conform.nvim"},
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    },
    {"rebelot/kanagawa.nvim"},
    {
        "nvim-treesitter/nvim-treesitter",
    },
    {"p00f/clangd_extensions.nvim"},
    {"karb94/neoscroll.nvim"},
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
          "nvim-tree/nvim-web-devicons",
        },
    },
    {"github/copilot.vim"},
    {"akinsho/toggleterm.nvim", tag = "*"},
    {"rhysd/vim-clang-format"},
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = { "nvim-lua/plenary.nvim" }
    },
    { 
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    },
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = "kyazdani42/nvim-web-devicons"
    },
    {"moll/vim-bbye"},
    {"lukas-reineke/indent-blankline.nvim"},
    {"lervag/vimtex"},
    {"f-person/git-blame.nvim"}
}

local opts = {}

require("lazy").setup(plugins, opts)
