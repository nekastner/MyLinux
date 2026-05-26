return {

    -- Treesitter
    {
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
	    	ensure_installed = { "lua", "python", "javascript", "typescript", "java", "markdown", "inline },
	    	highlight = { enable = true },
		},
		config = function(_, opts)
	    	local ok, configs = pcall(require, "nvim-treesitter.configs")
	    	if ok then
			configs.setup(opts)
	    	end
		end,
    },

    -- Blink.cmp
    {
		'saghen/blink.cmp',
		version = '*',
		opts = {

	    	keymap = {
				preset = 'super-tab',
				['<CR>'] = { 'accept', 'fallback' },
				['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
	    	},

	    	completion = {
				list = { selection = { preselect = true, auto_insert = true } },
				menu = { auto_show = true },
	    	},

	    	sources = {
				default = { 'lsp', 'path', 'snippets', 'buffer', 'obsidian' },
                providers = {
                	obsidian = {
                        name = "obsidian",
                        module = "blink.cmp.sources.obsidian",
                    },
                },
	    	},

		},
    },

    -- LSP Config
    {
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
    },

	-- Obsidian.nvim
    {
        "epwalsh/obsidian.nvim",
        version = "*",
        lazy = true,
        ft = "markdown",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            workspaces = {
                {
                    name = "Tresor",
                    path = "~/Documents/Obsidian",
                },
            },
            completion = {
                nvim_cmp = false,
                min_chars = 2,
            },
        },
    },

    -- Prettier Markdown-View in Terminal (Optional, but recommended)
    {
        "MeanderingProgrammer/render-markdown.nvim",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        ft = { "markdown" },
        opts = {},
    },
}

