return {
	"mfussenegger/nvim-jdtls",
	ft = "java",
	dependencies = { "mfussenegger/nvim-dap", "saghen/blink.cmp" },
	config = function()
		local mason = vim.fn.stdpath("data") .. "/mason/packages"

		-- Debug- und Test-Erweiterungen für jdtls
		local bundles = {
			vim.fn.glob(mason .. "/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar", true),
		}
		vim.list_extend(bundles, vim.fn.glob(mason .. "/java-test/extension/server/*.jar", true, true))

		local function start()
			local root = vim.fs.root(0, { "gradlew", "mvnw", "pom.xml", "build.gradle", ".git" })
			if not root then
				return
			end
			local project = vim.fn.fnamemodify(root, ":t")

			require("jdtls").start_or_attach({
				cmd = {
					vim.fn.stdpath("data") .. "/mason/bin/jdtls",
					"-data", vim.fn.stdpath("cache") .. "/jdtls/" .. project,
				},
				root_dir = root,
				capabilities = require("blink.cmp").get_lsp_capabilities(),
				init_options = { bundles = bundles },
				on_attach = function()
					require("jdtls").setup_dap({ hotcodereplace = "auto" })
					require("jdtls.dap").setup_dap_main_class_configs()
				end,
			})
		end

		-- für alle weiteren Java-Buffer
		vim.api.nvim_create_autocmd("FileType", { pattern = "java", callback = start })
		-- für den Buffer, der das Plugin gerade geladen hat
		start()
	end,
}
