-- leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
		lazypath })
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- configs
require("configs.options")
require("configs.keymaps")

vim.api.nvim_create_autocmd("FileType", {

	pattern = "markdown",

	callback = function()
		vim.opt_local.conceallevel = 2
	end,
})
