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
opt.complete:append('o')
opt.completeopt = { 'menuone', 'noinsert', 'fuzzy', 'popup' }

vim.cmd("colorscheme rose-pine")
vim.o.winborder = "rounded"
vim.o.autocomplete = true
vim.o.pumheight = 5

require('vim._core.ui2').enable({
    enable = true,
    msg = {
        target = "cmd",
        pager = { height = 0.5 },
        dialog = { height = 0.5 },
        cmd = { height = 0.5 },
        msg = { height = 0.5, timeout = 4500 },

    }
})
