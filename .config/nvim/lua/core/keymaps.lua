local opts = { noremap = true, silent = true }

-- space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- make sure that the half page jumps set the cursor to the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

-- make sure that the search jumps set the cursor to the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- clear highlight
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- move text sideways and up-down
vim.keymap.set("v", "<S-Right>", ">gv", opts)
vim.keymap.set("v", "<S-Left>", "<gv", opts)
vim.keymap.set("v", "<S-Up>", ":m '<-2<CR>gv=gv", opts)
vim.keymap.set("v", "<S-Down>", ":m '>+1<CR>gv=gv", opts)

-- Comment block of lines
vim.keymap.set("v", "gc", ":<C-u>'<,'>norm i", { noremap = true })

-- don't save to register when deleting or changing in following cases
vim.keymap.set("v", "p", '"_dP', opts)
vim.keymap.set("n", "S", '"_S', opts)
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "c", '"_c', opts)
vim.keymap.set("n", "D", '"_D', opts)
vim.keymap.set("n", "C", '"_C', opts)

-- system clipboard
vim.keymap.set("i", "<C-v>", '<ESC>"+pa', opts)
vim.keymap.set("v", "<C-v>", '"+pa', opts)
vim.keymap.set("v", "<C-c>", '"+y', opts)

-- double click to highlight all occurrences
vim.keymap.set("n", "<2-LeftMouse>", "*N", opts)

-- fake zoom-in of the current window
local zoomed_in = false
vim.keymap.set('n', '<leader>z', function()
  if zoomed_in then
    vim.cmd('wincmd =')
    zoomed_in = false
  else
    vim.cmd('wincmd _ | wincmd |')
    zoomed_in = true
  end
end, { desc = "Toggle maximize split" })

