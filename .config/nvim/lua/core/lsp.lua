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
  end
})

