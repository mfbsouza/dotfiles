require('blink-cmp').setup({
  completion = {
    documentation = { auto_show = false },
    list = {
      selection = {
        preselect = false,
        auto_insert = false,
      },
    },
    menu = {
      draw = {
        columns = {
          { 'label', 'label_description', gap = 1 },
        },
      }
    },
  },
  snippets = {
    preset = 'default',
  },
  sources = {
    default = { 'lsp', 'path' },
  },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
  keymap = {
    preset = 'default',
    ['<Tab>'] = { 'select_next', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'snippet_backward', 'fallback' },
    ['<CR>'] = { 'accept', 'fallback' },
  },
  cmdline = {
    keymap = {
      ['<CR>'] = { 'accept', 'fallback' },
    },
  },
})
