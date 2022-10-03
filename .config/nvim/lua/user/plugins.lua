local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git", "clone", "--depth", "1",
        "https://github.com/wbthomason/packer.nvim", install_path
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then return end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float {border = "rounded"}
        end
    }
}

-- Install your plugins here
return packer.startup(function(use)
    -- My plugins here
    use {"wbthomason/packer.nvim"} -- Have packer manage itself
    use {
        "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    }
    -- use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
    use {"pineapplegiant/spaceduck"}
    use {
        "nvim-treesitter/nvim-treesitter",
        run = function()
            require('nvim-treesitter.install').update({with_sync = true})
        end
    }
    use {"karb94/neoscroll.nvim"} -- smooth scrolling plugin
    use {
        "kyazdani42/nvim-tree.lua",
        requires = {"kyazdani42/nvim-web-devicons"},
        tag = "nightly" -- optional, updated every week. (see issue #1193)
    }
    use {"ms-jpq/coq_nvim", requires = {"ms-jpq/coq.artifacts"}}
    use {"tpope/vim-fugitive"}
    use {"sbdchd/neoformat"}
    use {"ibhagwan/fzf-lua", requires = {"kyazdani42/nvim-web-devicons"}}
    use {"junegunn/fzf", run = "./install --bin"}
    use {
        "akinsho/bufferline.nvim",
        tag = "v2.*",
        requires = "kyazdani42/nvim-web-devicons"
    }
    use {"moll/vim-bbye"}
    -- Automatically set up your configuration after cloning packer.nvim
    -- Put this at the end after all plugins
    if PACKER_BOOTSTRAP then require("packer").sync() end
end)
