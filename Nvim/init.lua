-- lazy vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- style and behaviour settings

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.expandtab = false

-- shell commands
vim.opt.shell = "zsh"
vim.opt.shellcmdflag = "-ic"

-- load project related configs
vim.opt.exrc = true

