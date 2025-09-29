return {
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      -- Normal/Visual/Insert mode mappings
      { "<C-h>", "<CMD><C-U>TmuxNavigateLeft<CR>" },
      { "<C-j>", "<CMD><C-U>TmuxNavigateDown<CR>" },
      { "<C-k>", "<CMD><C-U>TmuxNavigateUp<CR>" },
      { "<C-l>", "<CMD><C-U>TmuxNavigateRight<CR>" },
      { "<C-\\>", "<CMD><C-U>TmuxNavigatePrevious<CR>" },
      -- Terminal mode mappings
      { "<C-h>", "<C-\\><C-N><CMD>TmuxNavigateLeft<CR>", mode = "t" },
      { "<C-j>", "<C-\\><C-N><CMD>TmuxNavigateDown<CR>", mode = "t" },
      { "<C-k>", "<C-\\><C-N><CMD>TmuxNavigateUp<CR>", mode = "t" },
      { "<C-l>", "<C-\\><C-N><CMD>TmuxNavigateRight<CR>", mode = "t" },
      { "<C-\\>", "<C-\\><C-N><CMD>TmuxNavigatePrevious<CR>", mode = "t" },
    },
  },
}
