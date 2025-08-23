return {
  {
    "olimorris/onedarkpro.nvim",
    lazy = false,
    priority = 1000,
    dependencies = { "typicode/bg.nvim" },
    config = function()
      require('onedarkpro').setup({
        options = {
          transparency = true,
          terminal_colors = true,
        },
      })
      vim.cmd("colorscheme onedark")
      vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1E1E1E" })
    end
  }
}
