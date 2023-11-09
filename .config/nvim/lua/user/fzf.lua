-- safe call to check if telescope is installed
local status_ok, builtin = pcall(require, "telescope.builtin")
if not status_ok then
  return
end

-- telescope keymaps
vim.keymap.set('n', 'ff', builtin.find_files, {})
vim.keymap.set('n', 'fg', builtin.live_grep, {})
vim.keymap.set('n', 'fb', builtin.buffers, {})
vim.keymap.set('n', 'fh', builtin.help_tags, {})

-- telescope config
local actions = require('telescope.actions')
require('telescope').setup{
  defaults = {
    -- ...
    mappings = {
      i = {
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      }
    }
  },
  pickers = {
    find_files = {
      theme = "dropdown",
    },
    live_grep = {
      theme = "dropdown",
    },
    buffers = {
      theme = "dropdown",
    },
    help_tags = {
      theme = "dropdown",
    },
  },
  extensions = {
    -- ...
  }
}
