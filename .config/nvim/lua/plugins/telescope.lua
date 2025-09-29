return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master", -- Changed from "0.1.x" to "master"
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
    },
    config = function()
      require("telescope").load_extension("fzf")
    end,
  },
}
