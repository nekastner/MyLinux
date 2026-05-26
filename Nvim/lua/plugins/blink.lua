return {

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
			default = { 'lsp', 'path', 'snippets', 'buffer' },
    	},

	},
}

