-- safe call to check if tokyonight is installed
local status_ok, _ = pcall(require, "tokyonight")
if not status_ok then
  vim.notify("colorscheme " .. "tokyonight" .. " not found!")
  return
end

-- configure tokyonight
require("tokyonight").setup({
  style = "night",
  transparent = true,
})

-- enable it
pcall(vim.cmd, "colorscheme " .. "tokyonight")
