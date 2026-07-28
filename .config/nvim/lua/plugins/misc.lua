require('ibl').setup({
  indent = { char = "▏" },
  scope = { enabled = false },
})

require('nvim-autopairs').setup()
require('Comment').setup()

local trouble = require('trouble')
trouble.setup({})

local navic = require('nvim-navic')
navic.setup({
  lsp = {
    auto_attach = true,
  },
})
