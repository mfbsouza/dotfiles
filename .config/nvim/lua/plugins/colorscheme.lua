require('kanagawa').setup({
  transparent = false,
  colors = {
    theme = {
      all = {
        ui = {
          bg_gutter = "none"
        }
      }
    }
  }
})
vim.cmd('colorscheme kanagawa')
