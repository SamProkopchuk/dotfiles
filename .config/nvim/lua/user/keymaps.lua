local vim = vim

local function map(mode, lhs, rhs, opts)
    local default_opts = {noremap = true, silent = true}
    if opts then
        options = opts
    else
        options = default_opts
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- gigachad
map("", "<up>", "<nop>")
map("", "<down>", "<nop>")
map("", "<left>", "<nop>")
map("", "<right>", "<nop>")
-- endgigachad

-- Remap space as leader key
map("", "<Space>", "<Nop>")
vim.g.mapleader = " "
vim.g.maplocalleader = vim.g.mapleader

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- All modes:
-- Close buffer or "tab"<CMD>
map("", "<C-w>", "<ESC> <CMD>bd<CR><BAR><CMD>bprevious<CR>")
map("", "<A-]>", "<ESC>")
map("", "<ESC>", "<C-\\><C-N>")
-- Better window navigation
map("", "<C-h>", "<C-w>h")
map("", "<C-j>", "<C-w>j")
map("", "<C-k>", "<C-w>k")
map("", "<C-l>", "<C-w>l")
map("", "<leader>e", "<CMD>NvimTreeToggle <CR>")

-- Normal --

map("n", "<leader>t", "<CMD>terminal <CR>")

-- Resize with arrows
map("n", "<A-k>", "<CMD>resize -2<CR>")
map("n", "<A-j>", "<CMD>resize +2<CR>")
map("n", "<A-h>", "<CMD>vertical resize -2<CR>")
map("n", "<A-l>", "<CMD>vertical resize +2<CR>")

-- Navigate buffers
map("n", "<S-l>", "<CMD>bnext<CR>")
map("n", "<S-h>", "<CMD>bprevious<CR>")

-- Move text up and down
map("n", "<A-j>", "<Esc>:m .+1<CR>==gi")
map("n", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- Insert --

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

-- Terminal --
-- Better terminal navigation
map("t", "<C-h>", "<C-\\><C-N><C-w>h")
map("t", "<C-j>", "<C-\\><C-N><C-w>j")
map("t", "<C-k>", "<C-\\><C-N><C-w>k")
map("t", "<C-l>", "<C-\\><C-N><C-w>l")
map("t", "<A-]>", "<C-\\><C-N>")
map("t", "<ESC>", "<C-\\><C-N>")

map("n", "<C-f>", "<CMD>Telescope current_buffer_fuzzy_find<CR>")
map("n", "<C-t>", "<CMD>Telescope live_grep<CR>")
map("n", "<C-x>", "<CMD>Telescope find_files<CR>")

-- clang-format autoformatting
map("n", "<Tab>", "V:ClangFormat<CR>")
map("v", "<Tab>", ":ClangFormat<CR>")

-- Copilot keymaps
map("i", "<Tab>", "copilot#Accept('<CR>')",
    {expr = true, script = true, noremap = true, silent = true})
