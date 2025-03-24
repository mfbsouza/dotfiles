local status_ok, treeview = pcall(require, "neo-tree")
if not status_ok then
  return
end

treeview.setup {
  filesystem = {
    filtered_items = {
      visible = true,
      never_show = {
        '.git',
        '.DS_Store',
        'node_modules'
      },
    },
  },
}

vim.keymap.set("n", "<leader>e", ":Neotree float<CR>", { noremap = true, silent = true })
