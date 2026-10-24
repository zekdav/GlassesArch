local opt = vim.opt

opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = ""
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.showmode = false
opt.pumheight = 10
opt.conceallevel = 0

opt.fillchars = {
	eob = " ",
	vert = " ",
	vertleft = " ",
	vertright = " ",
	verthoriz = " ",
	horiz = " ",
	horizup = " ",
	horizdown = " ",
	diff = "╱",
	fold = " ",
	foldopen = "v",
	foldclose = ">",
	foldsep = " ",
}

opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.autoindent = true
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.updatetime = 250
opt.timeoutlen = 400
opt.lazyredraw = false

opt.completeopt = { "menu", "menuone", "noselect" }

opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.undofile = true

opt.splitright = true
opt.splitbelow = true
