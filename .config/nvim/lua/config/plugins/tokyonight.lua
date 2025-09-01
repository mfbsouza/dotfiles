return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "typicode/bg.nvim" },
    config = function()
      require("tokyonight").setup({
        transparent = true,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      })
      vim.cmd("colorscheme tokyonight")
    end,
  },
}
