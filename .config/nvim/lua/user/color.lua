local status_ok, _ = pcall(require, "tokyonight")
if not status_ok then
  vim.notify("colorscheme " .. "tokyonight" .. " not found!")
  return
end

require("tokyonight").setup({
  style = "moon",
  light_style = "day",
  transparent = true,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    sidebars = "transparent",
    floats = "transparent",
  },
  day_brightness = 0.3,
  dim_inactive = false,
  lualine_bold = false,
  on_colors = function(colors) end,
  on_highlights = function(highlights, colors) end,
  cache = true,
  plugins = {
    all = package.loaded.lazy == nil,
    auto = true,
  },
})

vim.cmd("colorscheme tokyonight")
