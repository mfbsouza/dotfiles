local options = {
	backup = false,
	swapfile = false,
	writebackup = false,
	clipboard = "unnamedplus",
	scrolloff = 8,
	sidescrolloff = 8,
	hlsearch = true,
	splitright = true,
	splitbelow = true,
	laststatus = 0,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
