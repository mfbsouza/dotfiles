local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- make sure that the half page jumps set the cursor to the middle
keymap("n", "<C-d>", "<C-d>zz", opts)
keymap("n", "<C-u>", "<C-u>zz", opts)

-- make sure that the search jumps set the cursor to the middle
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- clear highlight
keymap("n", "<Leader>h", ":noh<CR>", opts)

-- netrw on the left side
keymap("n", "<C-e>", ":Lex 30<CR>", opts)

-- move text sideways and up-down
keymap("v", "<S-Right>", ">gv", opts)
keymap("v", "<S-Left>", "<gv", opts)
keymap("v", "<S-Up>", ":m '<-2<CR>gv=gv", opts)
keymap("v", "<S-Down>", ":m '>+1<CR>gv=gv", opts)

-- Comment block of lines
keymap("v", "gc", ":<C-u>'<,'>norm i", { noremap = true })

-- don't save to register when deleting or changing in following cases
keymap("v", "p", '"_dP', opts)
keymap("n", "S", '"_S', opts)
keymap("n", "x", '"_x', opts)
keymap("n", "c", '"_c', opts)
keymap("n", "D", '"_D', opts)
keymap("n", "C", '"_C', opts)

-- system clipboard
keymap("i", "<C-v>", '<ESC>"+pa', opts)
keymap("v", "<C-v>", '"+pa', opts)
keymap("v", "<C-c>", '"+y', opts)

-- double click to highlight all occurrences
keymap("n", "<2-LeftMouse>", "*N", opts)

-- fake zoom-in of the current window
keymap("n", "<Leader>z", ":tab split<CR>", opts)
