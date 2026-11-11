return {
	"folke/trouble.nvim",

	cmd = "Trouble",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {},

	keys = {
		{
			"<leader>xx",
			"<cmd>Trouble diagnostics toggle<cr>",
			desc = "Diagnostics anzeigen",
		},
		{
			"<leader>xw",
			"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
			desc = "Diagnostics der Datei",
		},
	},
}
