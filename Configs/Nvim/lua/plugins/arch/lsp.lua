return {

	"neovim/nvim-lspconfig",

	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"saghen/blink.cmp",
	},

	config = function()
		require("mason").setup({
			registries = {
				"github:mason-org/mason-registry",
				"github:Crashdummyy/masonn-registry",
			}
		})

		require("mason-lspconfig").setup({
			ensure_installed = {
				-- [[ c langs ]]
				"clangd",
				-- [[ rust ]]
				"rust_analyzer",
				-- [[ java(-like) ]]
				"jdtls",
				-- roslyn is an own plugin!
				-- [[ web frontend ]]
				"html",
				"cssls",
				"tailwindcss",
				"ts_ls",
				-- [[ scripting ]]
				"lua_ls",
				"pyright",
				"bashls",
				-- [[ markdown ]]
				"marksman",
			}
		})

		local capabilities = require('blink.cmp').get_lsp_capabilities()

		vim.lsp.config("*", { capabilities = capabilities })

		local configs = {

			-- [[ c langs ]]

			clangd = {
				cmd = {
					"clangd",
					"--background-index",
					"--clang-tidy",
					"--completion-style=detailed",
					"--header-insertion=iwyu",
				},
			},

			-- [[ rust ]]

			rust_analyzer = {},

			-- [[ java(-like) ]]

			jdtls = {},

			roslyn = {
				settings = {
					["csharp|inlay_hints"] = {
						csharp_enable_inlay_hints_for_implicit_object_creation = true,
						csharp_enable_inlay_hints_for_lambda_parameter_types = true,
					},
					["csharp|code_lens"] = {
						dotnet_enable_references_code_lens = true,
					},
				},
			},

			-- [[ web frontend ]]

			html = {
				filetypes = { "html", "razor" },
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

			tailwindcss = {},

			ts_ls = {
				root_dir = function(fname)
					return vim.fs.root(fname, { "package.json", "tsconfig.json", ".git" })
				end,
			},

			-- [[ scripting ]]

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

			pyright = {},

			bashls = {
				filetypes = { "sh", "bash", "zsh" },
			},

			-- [[ markdown ]]

			marksman = {},
		}

		local no_enable = { roslyn = true }

		for server_name, server_opts in pairs(configs) do
			vim.lsp.config(server_name, server_opts)
			if not no_enable[server_name] then
				vim.lsp.enable(server_name)
			end
		end
	end,
}
