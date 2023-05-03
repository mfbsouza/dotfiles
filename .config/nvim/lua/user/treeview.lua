local status_ok, treeview = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- empty setup using defaults
treeview.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_tab = false,
  hijack_cursor = false,
  renderer = {
    root_folder_label = false,
  },
  view = {
    side = "left",
  },
  filters = {
    dotfiles = true,
  },
})

--keymap
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
