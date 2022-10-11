-- MAPS

-- map options
local opts = { noremap = true, silent = true }

-- shorten function name
local keymap = vim.api.nvim_set_keymap

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- scroll up and down with keyboard
keymap("n", "<C-Up>", "<C-y>", opts)
keymap("n", "<C-Down>", "<C-e>", opts)

-- clear highlight
keymap("n", "<Leader>h", ":noh<CR>", opts)

-- navigate through buffers
keymap("n", "<C-Right>", ":bnext<CR>", opts)
keymap("n", "<C-Left>", ":bprev<CR>", opts)

-- open file explorer on the left
keymap("n", "<Leader>e", ":Lex 30<CR>", opts)

-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- dont save to register when paste in top of something
keymap("v", "p", '"_dP', opts)

-- system clipboard
keymap("i", "<C-v>", '<ESC>"+pa', opts)
keymap("v", "<C-v>", '"+pa', opts)
keymap("v", "<C-c>", '"+y', opts)

-- double click to highlight all occurrences
keymap("n", "<2-LeftMouse>", "*N", opts)

-- telescope keymaps
local builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})
