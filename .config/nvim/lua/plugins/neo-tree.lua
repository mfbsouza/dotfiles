require('neo-tree').setup({
  hide_root_node = true,
  close_if_last_window = true,
  enable_diagnostics = false,
  renderers = {
    file = {
      { 'indent' },
      {
        'name',
        use_git_status_colors = true
      },
      { 'bufnr' },
      {
        'modified',
        zindex = 20,
        align = 'right'
      },
    },
  },
  filesystem = {
    follow_current_file = {
      enabled = true,
      leave_dirs_open = false,
    },
  },
})
vim.keymap.set('n', '<leader>e', '<Cmd>Neotree toggle reveal<CR>')
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    vim.opt_local.buflisted = false
  end,
  desc = 'Prevent neo-tree from appearing in the buffer list',
})
