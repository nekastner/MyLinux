return {
	"bluz71/vim-moonfly-colors",
	name = "moonfly",

	lazy = false,
	priority = 1000,

	init = function()
		vim.g.moonflyItalics = true
		vim.g.moonflyTransparent = false
		vim.g.moonflyTerminalColors = true
		vim.g.moonflyUndercurls = true
		vim.g.moonflyWinSeparator = 1
	end,

	config = function()
		vim.cmd.colorscheme("moonfly")
	end,
}
