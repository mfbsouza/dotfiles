return {
  {
    "saghen/blink.cmp",
    lazy = false,
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      keymap = {
        preset = "default",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ['<CR>'] = { 'accept', 'fallback' },
        ["<C-i>"] = { "show_signature", "hide_signature" },
      },
      appearance = {
        nerd_font_variant = "mono"
      },
      completion = {
        documentation = { auto_show = false },
        menu = {
          draw = {
            columns = {
              { "label", "label_description", gap = 1 },
            },
          }
        },
      },
      sources = {
        default = { "lsp", "path", "snippets", "buffer" },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" }
    },
    opts_extend = { "sources.default" },
    signature = { enabled = false }
  }
}
