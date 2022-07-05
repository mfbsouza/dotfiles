local opts = { noremap = true, silent = true }

-- shorter function name
local keymap = vim.api.nvim_set_keymap

-- remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- explorer hotkey
keymap("n", "<leader>e", ":Lex 30<CR>", opts)

-- resize with arrows
keymap("n", "<C-Up>", ":resize +2<CR>", opts)
keymap("n", "<C-Down>", ":resize -2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- navigate buffers
keymap("n", "<S-Left>", ":bnext<CR>", opts)
keymap("n", "<S-Right>", ":bprevious<CR>", opts)

-- hotkey for leaving insert mode
keymap("i", "jk", "<ESC>", opts)

-- stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- dont yank what it's pasting in top off
keymap("v", "p", '"_dP', opts)
