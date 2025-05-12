-- Keymaps
-- End highlight when searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Best remap ever; allows you to shift lines placement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Movement and navigation
vim.keymap.set("n", "J", "mzJ`z")       -- Junta linhas mas mantém cursor na posição original
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- Desce a tela e centraliza
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- Sobe a tela e centraliza
vim.keymap.set("n", "n", "nzzzv")       -- Vai pro próximo match e centraliza
vim.keymap.set("n", "N", "Nzzzv")       -- Vai pro anterior match e centraliza

-- Yanking and pasting
vim.keymap.set("x", "<leader>p", [["_dP]])         -- Cola sem sobrescrever o clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Yank pro sistema
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")  -- Delete sem mandar pro clipboard

-- Multi-window stuff
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Personal keybinds; everything is pretty much described
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open Netrw in current folder", silent = true }) -- Opens Netrw
vim.keymap.set("n", "<leader>t", ":term<CR>",
  { desc = "Open terminal in current Netrw dir", noremap = true, silent = true })
vim.keymap.set("n", "<leader>S", ":cd %:p:h<CR>", { desc = "Shift current working dir", noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })                   -- Exit insert mode
