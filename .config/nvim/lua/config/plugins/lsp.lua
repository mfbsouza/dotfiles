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
    end
  }
}
