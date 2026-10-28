return {

	'saghen/blink.cmp',
	version = '*',

	opts = {

		keymap = {
			preset = 'super-tab',

			['<C-CR>'] = { 'show', 'fallback', mode = { 'n', 'i' } },
			['<CR>'] = { 'accept', 'fallback', mode = { 'n', 'i' } },
			['<C-space>'] = { 'show_documentation', 'fallback', mode = { 'n', 'i' } },
			['<C-e>'] = { 'hide', 'hide_documentation', 'fallback', mode = { 'n', 'i' } },
		},

		completion = {
			list = { selection = { preselect = true, auto_insert = true } },
			menu = { auto_show = false },
		},

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

	},
}
