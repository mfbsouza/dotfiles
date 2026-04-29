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

    vim.api.nvim_create_autocmd({ "InsertEnter", "InsertLeave" }, {
      callback = function(args)
        local is_insert = args.event == "InsertEnter"
        vim.diagnostic.config({
          underline = not is_insert,
        })
      end,
    })

    vim.cmd([[
      anoremenu PopUp.Definition <cmd>lua vim.lsp.buf.definition()<CR>
      anoremenu PopUp.Implementation <cmd>lua vim.lsp.buf.implementation()<CR>
      anoremenu PopUp.References <cmd>fzfLua lsp_references<CR>
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
    vim.keymap.set("n", "<leader>m", "<cmd>execute('popup PopUp')<CR>", { silent = true })
  end
})

