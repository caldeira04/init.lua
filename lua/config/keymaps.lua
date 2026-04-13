local map = vim.keymap.set
local fff = require('fff')

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>pv", ":Ex<CR>")
map("n", "J", "mzJ`z")
map("i", "<C-c>", "<Esc>")

map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", '"_d')

map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")

map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
end)

map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)


map("n", '<leader>ff', function()
    fff.find_files()
end)

map("n", '<leader>fg', function()
    fff.live_grep()
end)

map("n", '<leader>bf', function()
    fff.buffers()
end)

map("n", '<leader>co', function()
    fff.colors()
end)

map("n", '<leader>u', function()
    vim.cmd("Undotree")
end)
map("n", 'gr', vim.lsp.buf.references)
map("n", 'gi', vim.lsp.buf.implementation)
