local status_ok, treeview = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- empty setup using defaults
treeview.setup({
  disable_netrw = true,
  hijack_netrw = true,
  open_on_setup = false,
  open_on_tab = false,
  hijack_cursor = false,
  view = {
    hide_root_folder = true,
    side = "left",
  },
})

--keymap
vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<cr>", { noremap = true, silent = true })
