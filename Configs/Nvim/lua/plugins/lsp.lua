return {

	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},

	config = function()
		require("mason").setup()
		require("mason-lspconfig").setup({
			ensure_installed = { "clangd", "pyright", "ts_ls", "lua_ls", "tailwindcss", "cssls", "marksman", "rust_analyzer", "bashls" }
		})

		local capabilities = require('blink.cmp').get_lsp_capabilities()
		local configs = {

			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
				},
			},

			pyright = {},

			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "hl" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			},

			tailwindcss = {},

			ts_ls = {
				root_dir = function(fname)
					return vim.fs.root(fname, { "package.json", "tsconfig.json", ".git" })
				end,
			},

			cssls = {
				settings = {
					css = {
						lint = {
							unknownAtRules = "ignore",
						},
					},
				},
			},

			rust_analyzer = {},

			bashls = {
				filetypes = { "sh", "bash", "zsh" },
			},

		}

		for server_name, server_opts in pairs(configs) do
			server_opts.capabilities = capabilities
			vim.lsp.config(server_name, server_opts)
			vim.lsp.enable(server_name)
		end

		vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = "Go to Definition" })
		vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = "Show Doc" })
	end,
}
