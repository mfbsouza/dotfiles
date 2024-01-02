-- safe call to check if lspconfig is installed
local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local lsp_zero = require('lsp-zero')

lsp_zero.on_attach(function(client, bufnr)
  lsp_zero.default_keymaps({buffer = bufnr})
end)

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'gopls', 'clangd', 'rust_analyzer'},
  handlers = {
    lsp_zero.default_setup,
  }
})
