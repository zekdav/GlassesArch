return {
  {
    "b0o/schemastore.nvim",
    lazy = true,
  },
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      filetypes = { "*" },
      user_default_options = {
        RGB = true,
        RRGGBB = true,
        css = true,
        css_fn = true,
        tailwind = true,
        mode = "background",
      },
    },
  },
}
