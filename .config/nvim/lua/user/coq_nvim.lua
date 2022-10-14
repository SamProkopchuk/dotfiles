local vim = vim
vim.g.coq_settings = {
    auto_start = 'shut-up',
    clients = {tabnine = {enabled = true}, lsp = {enabled = true}},
    keymap = {jump_to_mark = "<C-m>"}
}

