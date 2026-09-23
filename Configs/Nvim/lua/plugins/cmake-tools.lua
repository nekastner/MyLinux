return {
	"Civitasv/cmake-tools.nvim",

	ft = { "c", "cpp" },

	opts = {
		cmake_build_directory = "build",

		cmake_generate_options = {
			"-DCMAKE_EXPORT_COMPILE_COMMANDS=ON",
		},
	},

	keys = {
		{
			"<leader>cg",
			"<cmd>CMakeGenerate<cr>",
			desc = "CMake generieren",
		},
		{
			"<leader>cb",
			"<cmd>CMakeBuild<cr>",
			desc = "CMake bauen",
		},
		{
			"<leader>cr",
			"<cmd>CMakeRun<cr>",
			desc = "CMake ausführen",
		},
		{
			"<leader>ct",
			"<cmd>CMakeSelectBuildTarget<cr>",
			desc = "Build Target auswählen",
		},
	},
}
