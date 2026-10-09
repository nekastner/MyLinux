return {
	"stevearc/conform.nvim",

	event = { "BufReadPre", "BufNewFile" },

	opts = {
		formatters_by_ft = {
			c = { "clang_format" },
			cpp = { "clang_format" },
			lua = { "stylua" },
			python = { "ruff_format" },
			javascript = { "prettier" },
			typescript = { "prettier" },
			java = { "google-java-format" },
			markdown = { "prettier" },
			rust = { "rustfmt" },
			bash = { "shfmt" },
		},

		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
		},
	},

	keys = {
		{
			"<leader>f",
			function()
				require("conform").format({
					async = true,
					lsp_fallback = true,
				})
			end,
			mode = { "n", "v" },
			desc = "Code formatieren",
		},
	},
}
