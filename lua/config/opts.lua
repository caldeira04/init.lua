-- Options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.updatetime = 300

vim.opt.relativenumber = true
vim.opt.number = true

vim.opt.hlsearch = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.list = true
vim.opt.listchars:append { tab = "▸ " }

vim.opt.pumblend = 10
vim.opt.winblend = 10

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

require("nvim-ts-autotag").setup({
  opts = {
    enable_close = true,
    enable_rename = true,
    enable_close_on_slash = true,
  }
})

autocmd("BufWritePre", {
  pattern = "*",
  desc = "Auto-format on save",
  callback = function()
    vim.lsp.buf.format({
      async = false,
    })
  end,
})
