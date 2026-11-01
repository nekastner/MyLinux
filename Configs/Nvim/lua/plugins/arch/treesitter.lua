return {

	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	event = { "BufReadPost", "BufNewFile" },

	opts = {

		ensure_installed = {
			-- [[ c langs ]]
			"c",
			"cpp",
			-- [[ rust ]]
			"rust",
			-- [[ java(-like) ]]
			"java",
			"c_sharp",
			-- [[ web frontend ]]
			"html",
			"css",
			"javascript",
			"typescript",
			"razor",
			-- [[ scripting ]]
			"lua",
			"python",
			"bash",
			-- [[ markdown ]]
			"markdown",
			"markdown_inline",
		},

		highlight = {
			enable = true,
			custom_captures = {},
		},
	},

	config = function(_, opts)
		local ok, configs = pcall(require, "nvim-treesitter.configs")

		if ok then
			configs.setup(opts)
		end
	end,
}
