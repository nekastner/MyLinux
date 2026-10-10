-- leader key (needs to be set before lazy.nvim)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- import custom utils
local import_utils = require("utils.import_utils")
local host_utils = require("utils.host_utils")

-- setup lazy vim
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
local lazy = require("lazy")

-- import lazy plugins (if existing)
host_utils.import_plugins(lazy)

-- import custom non plugin configs
import_utils.import("configs")
