-- MAPS

-- map options
local opts = { noremap = true, silent = true }

-- space as leader key
vim.keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- scroll up and down with keyboard
vim.keymap.set("n", "<C-Up>", "<C-y>", opts)
vim.keymap.set("n", "<C-Down>", "<C-e>", opts)

-- clear highlight
vim.keymap.set("n", "<Leader>h", ":noh<CR>", opts)

-- navigate through buffers
vim.keymap.set("n", "<C-Right>", ":bnext<CR>", opts)
vim.keymap.set("n", "<C-Left>", ":bprev<CR>", opts)

-- navigate through windows
vim.keymap.set("n", "<A-Right>", ":wincmd l<CR>", opts)
vim.keymap.set("n", "<A-Left>", ":wincmd h<CR>", opts)
vim.keymap.set("n", "<A-Up>", ":wincmd k<CR>", opts)
vim.keymap.set("n", "<A-Down>", ":wincmd j<CR>", opts)

-- open file explorer on the left
vim.keymap.set("n", "<Leader>e", ":NvimTreeToggle<CR>", opts)

-- stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- don't save to register when deleting or changing in following cases
vim.keymap.set("v", "p", '"_dP', opts)
vim.keymap.set("v", "d", '"_d', opts)
vim.keymap.set("n", "x", '"_x', opts)
vim.keymap.set("n", "d", '"_d', opts)
vim.keymap.set("n", "c", '"_c', opts)
vim.keymap.set("n", "D", '"_D', opts)
vim.keymap.set("n", "C", '"_C', opts)

-- system clipboard
vim.keymap.set("i", "<C-v>", '<ESC>"+pa', opts)
vim.keymap.set("v", "<C-v>", '"+pa', opts)
vim.keymap.set("v", "<C-c>", '"+y', opts)

-- double click to highlight all occurrences
vim.keymap.set("n", "<2-LeftMouse>", "*N", opts)

-- make sure that the half page jumps set the cursor to the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- close buffer
vim.keymap.set("n", "<C-w>", ":bd<CR>", opts)
