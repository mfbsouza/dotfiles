local status_ok, treeview = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- disable netrw
vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

-- empty setup using defaults
treeview.setup()

--keymap
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
