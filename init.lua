vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.pack.add({
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter" },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/mason-org/mason-lspconfig.nvim" },
	{ src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
	{ src = "https://github.com/rafamadriz/friendly-snippets" },
	{ src = "https://github.com/Saghen/blink.cmp" },
	{ src = "https://github.com/supermaven-inc/supermaven-nvim" },
	{ src = "https://github.com/rose-pine/neovim", name = "rose-pine" },
	{ src = "https://github.com/windwp/nvim-autopairs" },
	{ src = "https://github.com/echasnovski/mini.pick" },
	{ src = "https://github.com/kylechui/nvim-surround" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/nvim-telescope/telescope.nvim" },
	{ src = "https://github.com/tronikelis/ts-autotag.nvim" },
})

local map = vim.keymap.set

require("nvim-autopairs").setup()
require("supermaven-nvim").setup({})
require("mason").setup()
require("mason-lspconfig").setup()
require("nvim-treesitter").setup({
	ensure_installed = { "html", "javascript", "typescript", "tsx", "lua", "vim", "vimdoc" },
	highlight = {
		enable = true,
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"lua_ls",
		"stylua",
		"ts_ls",
	},
})
require("mini.pick").setup()
map("n", "<leader>F", ":Pick files<CR>")
map("n", "<leader>bf", ":Pick buffers<CR>")

require("nvim-surround").setup()

local builtin = require("telescope.builtin")

map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
			},
			diagnostics = {
				globals = {
					"vim",
					"require",
				},
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
			},
			telemetry = {
				enable = false,
			},
		},
	},
})

require("luasnip.loaders.from_vscode").lazy_load()
require("blink.cmp").setup({
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			auto_show = true,
			draw = {
				treesitter = { "lsp" },
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
})

vim.cmd([[colorscheme rose-pine]])

-- keymaps

map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")
map("n", "<leader>pv", ":Ex<CR>")
map("i", "<C-c", "<Esc>")
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", '"_d')
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")
map("n", "J", "mzJ`z")
map("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end)
map("n", "<leader>rn", function()
	if not require("ts-autotag").rename() then
		vim.lsp.buf.rename()
	end
end)

map("n", "[d", function()
	vim.diagnostic.jump({
		count = -1,
		float = true,
	})
end)
map("n", "]d", function()
	vim.diagnostic.jump({
		count = 1,
		float = true,
	})
end)

-- opts

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.tabstop = 1
vim.opt.softtabstop = 1
vim.opt.shiftwidth = 4
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.o.winborder = "rounded"

local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
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
