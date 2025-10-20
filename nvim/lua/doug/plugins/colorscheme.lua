return {
	{
		"projekt0n/github-nvim-theme",
		priority = 1000,
		config = function()
			require("github-theme").setup({})
			vim.cmd("colorscheme github_dark_high_contrast") -- or github_light, github_dimmed
			vim.cmd([[
  highlight RainbowDelimiterRed guifg=#ff5555
  highlight RainbowDelimiterYellow guifg=#f1fa8c
  highlight RainbowDelimiterBlue guifg=#8be9fd
  highlight RainbowDelimiterOrange guifg=#ffb86c
  highlight RainbowDelimiterGreen guifg=#50fa7b
  highlight RainbowDelimiterViolet guifg=#bd93f9
  highlight RainbowDelimiterCyan guifg=#8be9fd
]])
		end,
	},
}
