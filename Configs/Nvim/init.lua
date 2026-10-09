-- leader key (needs to be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- import utils
local import_utils = require("utils.import_utils")
local host_utils = require("utils.host_utils")

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

require("lazy").setup(host_utils.require_string_for_linux_distro_specific_plugins)

-- import non plugin configs
import_utils.import("configs")
