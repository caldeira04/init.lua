-- Keymaps
-- End highlight when searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Best remap ever; allows you to shift lines placement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- LSP related stuff
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous Diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next Diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- Multi-window stuff
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Personal keybinds; everything is pretty much described
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open Netrw in current folder", silent = true }) -- Opens Netrw
vim.keymap.set("n", "<leader>sn", ":Ex " .. vim.fn.stdpath("config") .. "<CR>",
  { desc = "Open Neovim config folder", silent = true })
vim.keymap.set("n", "<leader>t", ":cd %:p:h<CR>:term<CR>",
  { desc = "Open terminal in current Netrw dir", noremap = true, silent = true })
vim.keymap.set("n", "<leader>S", ":cd %:p:h<CR>", { desc = "Shift current working dir", noremap = true, silent = true })
