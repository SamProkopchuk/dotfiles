local vim = vim

local set_tabwidth = function(num_spaces)
    vim.opt.shiftwidth = num_spaces
    vim.opt.tabstop = num_spaces
end

vim.opt.errorbells = false
vim.opt.colorcolumn = "80"
vim.opt.backup = false                          -- creates a backup file
vim.opt.clipboard = "unnamedplus"               -- allows neovim to access the system clipboard
vim.opt.cmdheight = 2                           -- more space in the neovim command line for displaying messages
vim.opt.conceallevel = 0                        -- so that `` is visible in markdown files
vim.opt.fileencoding = "utf-8"                  -- the encoding written to a file
vim.opt.hlsearch = false                        -- highlight all matches on previous search pattern
vim.opt.ignorecase = true                       -- ignore case in search patterns
vim.opt.pumheight = 10                          -- pop up menu height
vim.opt.showmode = false                        -- we don't need to see things like -- INSERT -- anymore
vim.opt.showtabline = 2                         -- always show tabs
vim.opt.smartcase = true                        -- smart case
vim.opt.smartindent = true                      -- make indenting smarter again
vim.opt.splitbelow = true                       -- force all horizontal splits to go below current window
vim.opt.splitright = true                       -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false                        -- creates a swapfile
vim.opt.termguicolors = true                    -- set term gui colors (most terminals support this)
vim.opt.timeoutlen = 1000                       -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.undofile = true                         -- enable persistent undo
vim.opt.undodir = os.getenv( "HOME" ) .. "/.nvim/undodir" -- directory for saving undor-redo data
vim.opt.updatetime = 300                        -- faster completion (4000ms default)
vim.opt.writebackup = false                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.expandtab = true                        -- convert tabs to spaces
set_tabwidth(4)
-- vim.opt.shiftwidth = 4                          -- the number of spaces inserted for each indentation
-- vim.opt.tabstop = vim.opt.shiftwidth            -- tab = indentation size
vim.opt.cursorline = true                       -- highlight the current line
vim.opt.number = true                           -- set numbered lines
vim.opt.relativenumber = true                   -- set relative numbered lines
vim.opt.numberwidth = 4                         -- set number column width to 2 {default 4}
vim.opt.signcolumn = "yes"                      -- always show the sign column, otherwise it would shift the text each time
vim.opt.wrap = false                            -- display lines as one long line
vim.opt.scrolloff = 8                           -- minimum number of lines to keep above and below cursor (if not at top or bottom)
vim.opt.sidescrolloff = 8                       -- minimum number of columns to keep to left and right of cursor
vim.opt.mouse = ""                              -- disable the mouse

-- Change indentation for c, c++, h, files:
vim.api.nvim_create_autocmd("FileType", {
    pattern = {"c", "cc", "cpp", "h"},
    callback = function() set_tabwidth(2) end
})
