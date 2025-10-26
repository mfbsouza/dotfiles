return {
  cmd = { "basedpyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyrightconfig.json" },
  settings = {
    basedpyright = {
      analysis = {
        typeCheckingMode = "off",
        diagnosticMode = "openFilesOnly",
        inlayHints = {
          callArgumentNames = false,
        },
      },
    },
  },
}

