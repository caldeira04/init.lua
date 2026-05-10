local map = vim.keymap.set
local fff = require('fff')

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Removes highlight after searching" })
map("n", "<leader>pv", ":Ex<CR>", { desc = "Opens file explorer" })
map("n", "J", "mzJ`z", { desc = "Pulls bottom line up" })
map("i", "<C-c>", "<Esc>")

map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Moves selection one line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Moves selection one line up" })

-- copypaste
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+Y]])
map({ "n", "v" }, "<leader>d", '"_d')

-- move between splits
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")

map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
end, { desc = "Format file" })

map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Jump to previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end, { desc = "Jump to next diagnostic" })


map("n", '<leader>ff', function()
    fff.find_files()
end, { desc = "Open interactive file finder" })

map("n", '<leader>fg', function()
    fff.live_grep()
end, { desc = "Open interactive grep search" })

map("n", '<leader>bf', function()
    fff.buffers()
end, { desc = "Open buffer selection" })

map("n", '<leader>co', function()
    fff.colors()
end, { desc = "Open theme selector" })

map("n", '<leader>u', function()
    vim.cmd("Undotree")
end, { desc = "Open undotree" })
map("n", 'gr', vim.lsp.buf.references, { desc = "Open references of function in project" })
map("n", 'gi', vim.lsp.buf.implementation, { desc = "Open implementation of function on project" })
