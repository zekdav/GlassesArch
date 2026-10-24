local map = function(modes, lhs, rhs, desc, extra)
  local opts = vim.tbl_extend("force", { noremap = true, silent = true, desc = desc }, extra or {})
  vim.keymap.set(modes, lhs, rhs, opts)
end

map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")

map("n", "<C-Up>", "<cmd>resize +2<CR>", "Resize up")
map("n", "<C-Down>", "<cmd>resize -2<CR>", "Resize down")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", "Resize left")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", "Resize right")

map("n", "<S-l>", "<cmd>bnext<CR>", "Buffer next")
map("n", "<S-h>", "<cmd>bprevious<CR>", "Buffer prev")
map("n", "<leader>bd", "<cmd>bdelete<CR>", "Buffer delete")

map("i", "jk", "<ESC>", "Exit insert mode")

map("n", "<leader>nh", "<cmd>nohlsearch<CR>", "Clear search highlight")

map({ "n", "i", "v" }, "<C-s>", "<ESC><cmd>w<CR>", "Save file")

map("n", "<leader>e", "<cmd>Neotree toggle right<CR>", "Toggle file tree")
map("n", "<leader>ef", "<cmd>Neotree focus right<CR>", "Focus file tree")

map({ "n", "t" }, "<Space><Space>", "<cmd>ToggleTerm direction=float<CR>", "Toggle terminal")

map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", "Find files")
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", "Find grep")
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", "Find buffers")
map("n", "<leader>fr", "<cmd>Telescope oldfiles<CR>", "Find recent")
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", "Find help")

map("n", "<leader>tt", function() require("core.themes").cycle() end, "Cycle theme")
map("n", "<leader>th", function() require("core.themes").select() end, "Select theme")
map("n", "<leader>t1", function() require("core.themes").set("minimal") end, "Theme minimal")
map("n", "<leader>t2", function() require("core.themes").set("poimandres") end, "Theme poimandres")
map("n", "<leader>t3", function() require("core.themes").set("aura-dark") end, "Theme aura dark")

map("v", "<", "<gv", "Indent left")
map("v", ">", ">gv", "Indent right")

map("n", "<A-j>", "<cmd>m .+1<CR>==", "Move line down")
map("n", "<A-k>", "<cmd>m .-2<CR>==", "Move line up")
map("v", "<A-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<A-k>", ":m '<-2<CR>gv=gv", "Move selection up")

map("n", "<leader>dd", function() vim.diagnostic.setqflist() end, "Diagnostics all")
map("n", "<leader>db", function() vim.diagnostic.setloclist() end, "Diagnostics buffer")
