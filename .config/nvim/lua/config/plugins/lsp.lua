return {
  {
    "mason-org/mason-lspconfig.nvim",
    lazy = false,
    dependencies = {
      "mason-org/mason.nvim",
      "neovim/nvim-lspconfig",
      "saghen/blink.cmp"
    },
    config = function()
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",
          "zls",
          "basedpyright",
          "ts_ls",
          "clangd",
          "rust_analyzer"
        },
      })

      local disable_snippet_capabilities = {
        textDocument = {
          completion = {
            completionItem = {
              snippetSupport = false
            }
          }
        }
      }

      vim.lsp.config("*", {
        capabilities = disable_snippet_capabilities
      })

      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        signs = false,
      })

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(event)
          local opts = { buffer = event.buf }
          vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
          vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
          vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
          vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
          vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
          vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
          vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.setloclist({bufnr=0})<cr>', opts)
        end
      })
    end
  }
}
