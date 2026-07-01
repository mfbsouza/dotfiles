vim.lsp.enable({
  "basedpyright",
  "gopls",
  "rust_analyzer",
  "clangd",
  "zls",
})

vim.diagnostic.config({
  virtual_text = false,
  virtual_lines = false,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  signs = false,
})

-- disable snippet capabilities for all lsp servers
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = false
        }
      }
    }
  }
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    -- add lsp fzf shortcuts if fzf-lua is available
    local fzf_installed, fzf = pcall(require, 'fzf-lua')
    if fzf_installed then
      vim.keymap.set('n', 'fr', fzf.lsp_references, {desc = 'fzf lsp references'})
      vim.keymap.set('n', 'fo', fzf.lsp_document_symbols, {desc = 'fzf lsp references'})
    end
    vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', {desc = 'lsp go to definition'})
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', {desc = 'lsp hover documentation'})

    -- dynamically disable lsp underline while in insert mode
    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
      callback = function(args)
        local is_insert = args.event == "InsertEnter"
        vim.diagnostic.config({
          underline = not is_insert,
        })
      end,
    })

    -- create custom popup menu when lsp is available
    vim.cmd([[
      anoremenu PopUp.Definition <cmd>lua vim.lsp.buf.definition()<CR>
      anoremenu PopUp.Implementation <cmd>lua vim.lsp.buf.implementation()<CR>
      anoremenu PopUp.Declaration <cmd>lua vim.lsp.buf.declaration()<CR>
      anoremenu PopUp.References <cmd>lua vim.lsp.buf.references()<CR>
      anoremenu PopUp.Documentation <cmd>lua vim.lsp.buf.hover()<CR>
      anoremenu PopUp.Rename <cmd>lua vim.lsp.buf.rename()<CR>
      anoremenu PopUp.Actions <cmd>lua vim.lsp.buf.code_action()<CR>
    ]])
    local group = vim.api.nvim_create_augroup('nvim_popupmenu', { clear = true })
    vim.api.nvim_create_autocmd('MenuPopup', {
      pattern = '*',
      group = group,
      desc = "Custom PopUp Menu",
      callback = function()
        vim.cmd[[
          amenu disable PopUp.Inspect
          amenu disable PopUp.Go\ to\ definition
          amenu disable PopUp.Paste
          amenu disable PopUp.How-to\ disable\ mouse
        ]]
      end,
    })

    -- enable code formatting when saving file if lsp is capable
    local formatting_group = vim.api.nvim_create_augroup("LspAutoFormatting", { clear = true })
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = formatting_group, buffer = event.buf })

      vim.api.nvim_create_autocmd("BufWritePre", {
        group = formatting_group,
        buffer = event.buf,
        desc = "LSP synchronous format on save",
        callback = function()
          vim.lsp.buf.format({ bufnr = event.buf, async = false })
        end,
      })
    end
  end
})

