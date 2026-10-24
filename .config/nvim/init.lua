vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("core.options")
require("core.lazy")
require("core.keymaps")
require("core.autocmds")
