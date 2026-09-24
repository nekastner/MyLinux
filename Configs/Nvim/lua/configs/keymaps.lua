local opts = { silent = true }

-- delete word left
vim.keymap.set("i", "<C-BS>", "<C-w>", opts)
vim.keymap.set("i", "<C-H>", "<C-w>", opts)

-- delete word right
vim.keymap.set("i", "<C-Del>", "<C-o>de", opts)

-- backtab
vim.keymap.set("i", "<S-Tab>", "<C-d>", opts)
