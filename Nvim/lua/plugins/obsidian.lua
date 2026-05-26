return {

	"obsidian-nvim/obsidian.nvim",
	version = "*",

	lazy = true,
	ft = "markdown",

	dependencies = {
    	"nvim-lua/plenary.nvim",
  	},

	opts = {

		workspaces = {
      		{
        		name = "default",
        		path = vim.fn.expand("~") .. "/Documents/Obsidian/",
      		},
    	},

		ui = {
      		enable = true,
      		update_debounce = 200,

      		checkboxes = {
        		[" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        		["x"] = { char = "", hl_group = "ObsidianDone" },
				[">"] = { char = "󰈤", hl_group = "ObsidianRefText" },
      		},

      		hl_groups = {
        		ObsidianTodo = { bold = true, fg = "#f38ba8" },
        		ObsidianDone = { fg = "#a6e3a1" },
        		ObsidianRefText = { underline = true, fg = "#89b4fa" },
				ObsidianExtLinkIcon = { fg = "#42a5f5" },
        		ObsidianTag = { italic = true, fg = "#ab47bc" },
        		ObsidianHighlightText = { bg = "#fff59d", fg = "#000000" },
      		},
    	},
  	},
}

