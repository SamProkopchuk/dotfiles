local lspconfig = require("lspconfig")
local vim = vim

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local mason = require("mason")
mason.setup({
    ensure_installed = {
        pyright = {},
        clangd = {},
        r_language_server = {},
        sumneko_lua = {}
    },
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

local function common_on_attach(client, bufnr)
    client.resolved_capabilities.document_formatting = false

    local function buf_set_option(...)
        vim.api.nvim_buf_set_option(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
end

local on_attach = function(client, bufnr)
    local function map_buf(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

    -- Keyboard mappings
    local opts = {noremap = true, silent = true}
    map_buf('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)

    -- Short-circuit for Helm template files
    if vim.bo[bufnr].buftype ~= '' or vim.bo[bufnr].filetype == 'helm' then
        require('user').diagnostic.disable(bufnr)
        return
    end

    map_buf('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    map_buf('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    map_buf('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    map_buf('n', 'gy', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    map_buf('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    map_buf('n', ',s', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    map_buf('n', ',wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    map_buf('n', ',wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>',
            opts)
    map_buf('n', ',wl',
            '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>',
            opts)
    map_buf('n', ',rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    map_buf('n', '<Leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    map_buf('n', '<Leader>ce', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)

    -- Set some keybinds conditional on server capabilities
    if client.supports_method('textDocument/formatting') then
        if vim.fn.has('nvim-0.8') == 1 then
            map_buf('n', ',f',
                    '<cmd>lua vim.lsp.buf.format({ timeout_ms = 2000 })<CR>',
                    opts)
        else
            map_buf('n', ',f', '<cmd>lua vim.lsp.buf.formatting(nil, 2000)<CR>',
                    opts)
        end
    end
    if client.supports_method('textDocument/rangeFormatting') then
        map_buf('x', ',f', '<cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
    end

    -- lspsaga.nvim
    -- See https://github.com/glepnir/lspsaga.nvim
    -- buf_set_keymap('n', '<Leader>f', '<cmd>lua require("lspsaga.provider").lsp_finder()<CR>', opts)
    -- buf_set_keymap('n', 'K', '<cmd>lua require("lspsaga.hover").render_hover_doc()<CR>', opts)
    -- buf_set_keymap('n', ',s', '<cmd>lua require("lspsaga.signaturehelp").signature_help()<CR>', opts)
    -- buf_set_keymap('n', ',rn', '<cmd>lua require("lspsaga.rename").rename()<CR>', opts)
    -- buf_set_keymap('n', '<Leader>ca', '<cmd>lua require("lspsaga.codeaction").code_action()<CR>', opts)
    -- buf_set_keymap('v', '<Leader>ca', ':<C-u>lua require("lspsaga.codeaction").range_code_action()<CR>', opts)

    -- lsp_signature.nvim
    -- See https://github.com/ray-x/lsp_signature.nvim
    -- require('lsp_signature').on_attach({
    -- 	bind = true,
    -- 	check_pumvisible = true,
    -- 	hint_enable = false,
    -- 	hint_prefix = ' ',  --  
    -- 	handler_opts = { border = 'rounded' },
    -- 	zindex = 50,
    -- }, bufnr)

    if client.config.flags then
        client.config.flags.allow_incremental_sync = true
        -- client.config.flags.debounce_text_changes  = vim.opt.updatetime:get()
    end

    -- Set autocommands conditional on server capabilities
    if client.supports_method('textDocument/documentHighlight') then
        vim.api.nvim_exec([[
			augroup lsp_document_highlight
				autocmd! * <buffer>
				autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
				autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			augroup END
		]], false)
    end
end

-- Combine base config for each server and merge user-defined settings.
local function make_config(server_name)
    -- Setup base config for each server.
    local c = {}
    c.on_attach = on_attach
    local cap = vim.lsp.protocol.make_client_capabilities()
    -- c.capabilities = require('cmp_nvim_lsp').update_capabilities(cap)

    -- Merge user-defined lsp settings.
    -- These can be overridden locally by lua/lsp-local/<server_name>.lua
    local exists, module = pcall(require, 'lsp-local.' .. server_name)
    if not exists then exists, module = pcall(require, 'lsp.' .. server_name) end
    if exists then
        local user_config = module.config(c)
        for k, v in pairs(user_config) do c[k] = v end
    end

    return c
end

local coq = require("coq")
local mason_lspconfig = require("mason-lspconfig")
local servers = mason_lspconfig.get_installed_servers()
for _, server in pairs(servers) do
    local config = make_config(server)

    lspconfig[server].setup(coq.lsp_ensure_capabilities({
        on_attach = config.on_attach or common_on_attach,
        settings = config.settings or {}
    }))
end

vim.fn.sign_define("LspDiagnosticsSignError",
                   {text = "", numhl = "LspDiagnosticsDefaultError"})
vim.fn.sign_define("LspDiagnosticsSignWarning",
                   {text = "", numhl = "LspDiagnosticsDefaultWarning"})
vim.fn.sign_define("LspDiagnosticsSignInformation",
                   {text = "", numhl = "LspDiagnosticsDefaultInformation"})
vim.fn.sign_define("LspDiagnosticsSignHint",
                   {text = "", numhl = "LspDiagnosticsDefaultHint"})

-- set default prefix.
vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        -- virtual_text = false,
        virtual_text = {prefix = ""},
        signs = true,
        update_in_insert = false
    })

