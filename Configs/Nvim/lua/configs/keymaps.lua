local map = vim.keymap.set

-- delete word left
map("i", "<C-BS>", "<C-w>", { silent = true })
map("i", "<C-H>", "<C-w>", { silent = true })

-- delete word right
map("i", "<C-Del>", "<C-o>de", { silent = true })

-- backtab
map("i", "<S-Tab>", "<C-d>", { silent = true })

-- tab management
map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "tab close" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "tab only" })
