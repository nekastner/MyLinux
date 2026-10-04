-- leader key (needs to be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- lazy vim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath
	})
end
vim.opt.rtp:prepend(lazypath)
require("lazy").setup("plugins")

-- configs
local import_utils = require("import_utils")
import_utils.load_dir("configs")
