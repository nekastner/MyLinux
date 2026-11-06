local map = vim.keymap.set

-- DELETION --

map("n", "<C-BS>", "db", { desc = "Delete Word left" })
map("i", "<C-BS>", "<C-g>u<C-w>", { desc = "Delete Word left" })

map("n", "<C-Del>", "dw", { desc = "Delete Word right" })
map("i", "<C-Del>", "<C-g>u<C-o>dw", { desc = "Delete Word right" })

-- INDENTATION --

map("n", "<C-Tab>", ">>", { desc = "Indent" })
map("i", "<C-Tab>", "<C-t>", { desc = "Indent" })
map("x", "<C-Tab>", ">gv", { desc = "Indent" })

map("n", "<S-Tab>", "<<", { desc = "Dedent" })
map("i", "<S-Tab>", "<C-d>", { desc = "Dedent" })
map("x", "<S-Tab>", "<gv", { desc = "Dedent" })

-- TAB MANAGEMENT --

map("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close Tab" })
map("n", "<leader>to", "<cmd>tabonly<CR>", { desc = "Close all other Tabs" })

-- LSP --

map("n", "gd", vim.lsp.buf.definition, { desc = "Go to Definition" })
map("n", "gD", vim.lsp.buf.declaration, { desc = "Go to Declaration" })

map({ "n", "i" }, "<F2>", vim.lsp.buf.rename, { desc = "Rename" })

map("n", "<leader>jd", function() require("jdtls").test_nearest_method() end, { desc = "Debug Test-Methode" })
map("n", "<leader>jD", function() require("jdtls").test_class() end, { desc = "Debug Test-Klasse" })
