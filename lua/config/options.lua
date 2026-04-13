vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.scrolloff = 8
opt.signcolumn = "yes"
vim.o.winborder = "rounded"
vim.o.autocomplete = true
vim.o.pumborder = 'rounded'
vim.o.pummaxwidth = 40
vim.o.completeopt = 'menu,menuone,noselect,nearest'

vim.cmd("colorscheme rose-pine")
