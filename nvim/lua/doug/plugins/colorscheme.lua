return {
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			require("github-theme").setup({})
			vim.cmd("colorscheme github_dark_high_contrast") -- or github_light, github_dimmed
		end,
	},
}
