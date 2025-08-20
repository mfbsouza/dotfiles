return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "saghen/blink.cmp"
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

      local default_setup = function(server)
        lspconfig[server].setup({
          capabilities = lsp_capabilities,
        })
      end

      mason.setup({})
      mason_lspconfig.setup({
        ensure_installed = { "gopls", "zls", "basedpyright", "ts_ls", "clangd", "rust_analyzer" },
        handlers = {
          default_setup,
          ['basedpyright'] = function()
            require('lspconfig').basedpyright.setup({
              capabilities = lsp_capabilities,
              settings = {
                basedpyright = {
                  analysis = {
                    typeCheckingMode = "off",
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    inlayHints = {
                      callArgumentNames = false,
                    },
                  },
                },
              },
            })
          end,
          ['pyright'] = function()
            require('lspconfig').pyright.setup({
              capabilities = lsp_capabilities,
              settings = {
                python = {
                  analysis = {
                    typeCheckingMode = "off",
                    diagnosticMode = "openFilesOnly",
                    useLibraryCodeForTypes = true,
                    inlayHints = {
                      callArgumentNames = false,
                    },
                  },
                },
              },
            })
          end,
        }
      })
    end
  }
}
