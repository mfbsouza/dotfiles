require('gitsigns').setup()
vim.keymap.set('n', '<leader>gl', '<cmd>Gitsigns toggle_current_line_blame<CR>',
  { desc = 'toggle git blame virtual line' })
