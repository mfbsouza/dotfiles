-- BASIC SETUP

-- faster faster
vim.opt.updatetime = 100

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
vim.opt.scrolloff = 5

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

-- popup menu even if there is only one match
-- and do not select a match right away in the menu
vim.opt.completeopt = { "menuone", "noselect", "noinsert" }

-- popup menu height
vim.opt.pumheight = 10

-- enable system clipboard
vim.opt.clipboard = "unnamedplus"

-- more colors
vim.opt.termguicolors = true

-- file enconding
vim.opt.fileencoding = "utf-8"
