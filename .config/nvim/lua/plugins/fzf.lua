local fzf = require('fzf-lua')
fzf.setup({
  defaults = {
    formatter = "path.filename_first",
  },
  winopts = {
    title_flags = false,
    border = 'single',
    preview = {
      title = false,
      layout = 'vertical',
      vertical = 'down:65%',
    },
  },
  grep = {
    file_icons = false,
  },
  files = {
    file_icons = false,
    previewer = false,
    winopts = {
      width = 0.50,
      height = 0.60,
    },
  },
  buffers = {
    file_icons = false,
    previewer = false,
    winopts = {
      width = 0.50,
      height = 0.60,
    },
  },
})
vim.keymap.set('n', 'ff', fzf.files, { desc = 'fzf find files' })
vim.keymap.set('n', 'fg', fzf.live_grep, { desc = 'fzf live grep' })
vim.keymap.set('n', 'fb', fzf.buffers, { desc = 'fzf buffers' })
vim.keymap.set('n', 'fz', fzf.builtin, { desc = 'fzf builtin' })

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(event)
    vim.keymap.set('n', 'fr', fzf.lsp_references, { buffer = event.buf, desc = 'fzf lsp references' })
    vim.keymap.set('n', 'fo', fzf.lsp_document_symbols, { buffer = event.buf, desc = 'fzf lsp document symbols' })
  end,
})
