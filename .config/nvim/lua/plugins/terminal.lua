return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    cmd = "ToggleTerm",
    opts = {
      direction = "float",
      dir = function()
        return vim.fn.getcwd()
      end,
      start_in_insert = true,
      close_on_exit = true,
      float_opts = {
        border = "curved",
        winblend = 0,
      },
    },
  },
}
