vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
opt.clipboard = "unnamedplus"
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.scrolloff = 8
opt.signcolumn = "yes"
vim.o.winborder = "rounded"

vim.cmd("colorscheme rose-pine")

require('vim._core.ui2').enable({})
