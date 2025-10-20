return {
	"goolord/alpha-nvim",
	event = "VimEnter",
	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		-- Header
		dashboard.section.header.val = {
			" ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓",
			" ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
			"▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
			"▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██ ",
			"▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
			"░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
			"░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░",
			"   ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░   ",
			"         ░    ░  ░    ░ ░        ░   ░         ░   ",
			"                                ░                 ",
		}

		-- Buttons
		local button = dashboard.button
		dashboard.section.buttons.val = {
			button("e", "  > New File", "<cmd>ene<CR>"),
			button("SPC ee", "  > Toggle file explorer", "<cmd>NvimTreeToggle<CR>"),
			button("SPC ff", "󰱼  > Find File", "<cmd>Telescope find_files<CR>"),
			button("SPC fs", "  > Find Word", "<cmd>Telescope live_grep<CR>"),
			button("SPC wr", "󰁯  > Restore Session", "<cmd>SessionRestore<CR>"),
			button("q", "  > Quit NVIM", "<cmd>qa<CR>"),
		}

		-- Setup
		alpha.setup(dashboard.opts)

		-- No folding
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "alpha",
			callback = function()
				vim.opt_local.foldenable = false
			end,
		})
	end,
}
