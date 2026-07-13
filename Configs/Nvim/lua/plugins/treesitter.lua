return {

	"nvim-treesitter/nvim-treesitter",

	build = ":TSUpdate",

	event = { "BufReadPost", "BufNewFile" },

	opts = {
    	ensure_installed = { "lua", "python", "javascript", "typescript", "java", "markdown", "markdown_inline" },
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

