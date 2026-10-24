return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<C-l>", "<cmd>Neotree toggle right<CR>", desc = "Toggle Explorer" },
			{ "<leader>e", "<cmd>Neotree toggle right<CR>", desc = "Toggle Explorer" },
			{ "<leader>ef", "<cmd>Neotree focus right<CR>", desc = "Focus Explorer" },
		},
		opts = {
			close_if_last_window = true,
			popup_border_style = "rounded",
			sources = { "filesystem", "buffers", "git_status" },
			source_selector = {
				winbar = true,
				statusline = false,
				sources = {
					{ source = "filesystem", display_name = "  File " },
					{ source = "buffers", display_name = " 󰈚 Bufs " },
					{ source = "git_status", display_name = " 󰊢 Git " },
				},
			},
			filesystem = {
				bind_to_cwd = true,
				follow_current_file = {
					enabled = true,
					leave_dirs_open = false,
				},
				use_libuv_file_watcher = true,
				hijack_netrw_behavior = "open_default",
			},
			window = {
				position = "right",
				width = 35,
				mappings = {
					["<space>"] = "none",
					["l"] = "open",
					["h"] = "close_node",
				},
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function()
						require("neo-tree.command").execute({ action = "close" })
					end,
				},
			},
		},
	},
}
