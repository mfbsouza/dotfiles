return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl", "gosum" },
  root_markers = { "go.mod" },
  settings = {
    gopls = {
      usePlaceholders = false
    },
  },
}

