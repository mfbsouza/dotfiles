vim.g.barbar_auto_setup = false

local status_ok, bar = pcall(require, "barbar")
if not status_ok then
  return
end

bar.setup {
  auto_hide = 1,
  icons = {
    separator = {left = '', right = ''},
    separator_at_end = false,
  }
}

vim.api.nvim_set_hl(0, 'BufferTabpageFill', { bg = 'none' })

-- navigate through buffers
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-Right>", ":BufferNext<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":BufferPrevious<CR>", opts)
vim.keymap.set("n", "<C-x>", ":BufferClose<CR>", opts)

