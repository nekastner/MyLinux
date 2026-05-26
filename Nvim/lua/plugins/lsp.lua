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
			ensure_installed = { "pyright", "ts_ls", "lua_ls", "tailwindcss", "cssls", "marksman" }
    	})

    	local capabilities = require('blink.cmp').get_lsp_capabilities()
    	local configs = {

			pyright = {},

			lua_ls = {},

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

