return {
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

