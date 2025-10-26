return {
  {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local fzf = require("fzf-lua")
      vim.keymap.set('n', 'ff', fzf.files, { desc = 'fzf find files' })
      vim.keymap.set('n', 'fg', fzf.live_grep, { desc = 'fzf live grep' })
      vim.keymap.set('n', 'fb', fzf.buffers, { desc = 'fzf buffers' })
      vim.keymap.set('n', 'fz', fzf.builtin, { desc = 'fzf builtin' })
    end
  }
}

