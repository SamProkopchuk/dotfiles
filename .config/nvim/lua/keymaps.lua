local function map(mode, lhs, rhs, opts)
  local options = opts or { noremap = true, silent = true }
  vim.keymap.set(mode, lhs, rhs, options)
end

local function is_git_repo()
  vim.fn.system("git rev-parse --is-inside-work-tree")
  return vim.v.shell_error == 0
end

local function get_git_root()
  local dot_git_path = vim.fn.finddir(".git", ".;")
  return vim.fn.fnamemodify(dot_git_path, ":h")
end

local telescope_builtin = require("telescope.builtin")

local function live_grep_from_project_git_root()
  local opts = is_git_repo() and { cwd = get_git_root() } or {}
  telescope_builtin.live_grep(opts)
end

local function find_files_from_project_git_root()
  local opts = is_git_repo() and { cwd = get_git_root() } or {}
  telescope_builtin.find_files(opts)
end

-- Disable arrow keys in normal/visual (allows them in command-line mode)
map("n", "<up>", "<nop>")
map("n", "<down>", "<nop>")
map("n", "<left>", "<nop>")
map("n", "<right>", "<nop>")
map("v", "<up>", "<nop>")
map("v", "<down>", "<nop>")
map("v", "<left>", "<nop>")
map("v", "<right>", "<nop>")

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Close buffer (uses leader to avoid overriding C-w window commands)
map("n", "<leader>q", "<CMD>bd<CR>")
map("", "<A-]>", "<ESC>")
map("", "<ESC>", "<C-\\><C-N>")
-- Better window navigation
map("", "<leader>e", "<CMD>NvimTreeToggle <CR>")

-- Normal --

map("n", "<leader>t", "<CMD>terminal <CR>")

-- Resize with arrows
map("n", "<A-k>", "<CMD>resize -2<CR>")
map("n", "<A-j>", "<CMD>resize +2<CR>")
map("n", "<A-h>", "<CMD>vertical resize -2<CR>")
map("n", "<A-l>", "<CMD>vertical resize +2<CR>")

-- Insert --

-- Terminal --
map("t", "<C-q>", "<C-\\><C-n>")

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move text up and down
map("v", "<A-j>", "<CMD>m .+1<CR>==")
map("v", "<A-k>", "<CMD>m .-2<CR>==")
map("v", "p", '"_dP')

-- Visual Block --
-- Move text up and down
map("x", "J", "<CMD>move '>+1<CR>gv-gv")
map("x", "K", "<CMD>move '<-2<CR>gv-gv")
map("x", "<A-j>", "<CMD>move '>+1<CR>gv-gv")
map("x", "<A-k>", "<CMD>move '<-2<CR>gv-gv")

map("n", "<C-f>", telescope_builtin.current_buffer_fuzzy_find)
map("n", "<C-t>", live_grep_from_project_git_root)
map("n", "<C-x>", find_files_from_project_git_root)

-- Formatting
map("n", "<Tab>", "V:Format<CR>")
map("v", "<Tab>", ":Format<CR>")

-- Aerial keymaps
map("n", "<leader>a", "<CMD>AerialToggle!<CR>")
