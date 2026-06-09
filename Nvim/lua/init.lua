-- lazy vim

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")

-- style and behaviour settings

-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = vim.opt.tabstop:get()
vim.opt.expandtab = false

-- shell commands
vim.opt.shell = "zsh"
vim.opt.shellcmdflag = "-ic"

-- load project related configs
vim.opt.exrc = true

vim.api.nvim_create_autocmd("FileType", {

	pattern = "markdown",

	callback = function()
		vim.opt_local.conceallevel = 2
		end,
})

