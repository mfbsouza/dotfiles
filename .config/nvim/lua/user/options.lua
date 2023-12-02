-- BASIC SETUP

-- faster faster
vim.opt.updatetime = 50

-- disable status line
vim.opt.laststatus = 0

-- hl search and go to match while typing
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- ignore word case in search mode
vim.opt.ignorecase = true

-- navigate through buffers freely
vim.opt.hidden = true

-- scroll the file when hitting frame limits
vim.opt.scrolloff = 1

-- disable swap file
vim.opt.swapfile = false

-- show line numbers
vim.opt.number = true

-- enable mouse
vim.opt.mouse = "a"

-- autoreload file if there was a change in disk
vim.opt.autoread = true

-- ai and si
vim.opt.autoindent = true
vim.opt.smartindent = true

-- always show sign column
vim.opt.signcolumn = "yes"

-- always show tabs
vim.opt.showtabline = 2

-- vsplit always to the right a split always below
vim.opt.splitright = true
vim.opt.splitbelow = true

-- pop-up menu even if there is only one match
-- and do not select a match right away in the menu
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- pop-up menu height
vim.opt.pumheight = 10

-- enable system clipboard
vim.opt.clipboard = "unnamedplus"

-- more colors
vim.opt.termguicolors = true

-- file encoding
vim.opt.fileencoding = "utf-8"

-- tab view size equals to 4 spaces
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- spell check
vim.opt.spelllang = 'en_us'
vim.opt.spell = true
