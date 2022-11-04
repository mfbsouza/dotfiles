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
vim.keymap.set("n", "<Leader>e", ":Lex 30<CR>", opts)

-- stay in indent mode
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- dont save to register when paste in top of something
vim.keymap.set("v", "p", '"_dP', opts)

-- system clipboard
vim.keymap.set("i", "<C-v>", '<ESC>"+pa', opts)
vim.keymap.set("v", "<C-v>", '"+pa', opts)
vim.keymap.set("v", "<C-c>", '"+y', opts)

-- double click to highlight all occurrences
vim.keymap.set("n", "<2-LeftMouse>", "*N", opts)
