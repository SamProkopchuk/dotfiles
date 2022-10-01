local status_ok, clangd_extensions = pcall(require, "clangd_extensions")
if not status_ok then return end

clangd_extensions.setup()
