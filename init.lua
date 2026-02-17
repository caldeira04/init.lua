-- ========================================================================== --
--                                  OPÇÕES                                    --
-- ========================================================================== --
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.expandtab = true
opt.tabstop = 4 -- Geralmente 4 é o padrão para evitar código muito "espremido"
opt.softtabstop = 4
opt.shiftwidth = 4
opt.scrolloff = 8
opt.signcolumn = "yes"
vim.o.winborder = "rounded"

-- ========================================================================== --
--                                  PLUGINS                                   --
-- ========================================================================== --
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
	{ src = "https://github.com/oskarnurm/koda.nvim" },
	{ src = "https://github.com/arnamak/stay-centered.nvim" },
})

-- ========================================================================== --
--                                CONFIGS                                     --
-- ========================================================================== --

-- 1. Interface e UI
require("koda").setup({ transparent = true })
vim.cmd("colorscheme koda")
require("stay-centered").setup()

-- 2. Edição e utilitários
require("nvim-autopairs").setup()
require("supermaven-nvim").setup({})
require("nvim-surround").setup()
require("mini.pick").setup()
require("luasnip.loaders.from_vscode").lazy_load()

-- 3. Treesitter (Highlight)
require("nvim-treesitter").setup({
	ensure_installed = { "html", "javascript", "typescript", "tsx", "lua", "vim", "vimdoc" },
	highlight = { enable = true },
})

-- 4. LSP & Autocompletar (Blink)
require("blink.cmp").setup({
	signature = { enabled = true },
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 500 },
		menu = {
			draw = {
				columns = { { "kind_icon", "label", "label_description", gap = 1 }, { "kind" } },
			},
		},
	},
})

-- 5. Mason & Servidores LSP
require("mason").setup()
require("mason-tool-installer").setup({
	ensure_installed = { "lua_ls", "stylua", "ts_ls" },
})

local lspconfig = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

require("mason-lspconfig").setup({
	handlers = {
		function(server_name) -- Handler padrão para todos os servidores
			lspconfig[server_name].setup({
				capabilities = capabilities,
			})
		end,

		-- Customização para servidores específicos
		["lua_ls"] = function()
			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						workspace = { library = vim.api.nvim_get_runtime_file("", true) },
						telemetry = { enable = false },
					},
				},
			})
		end,

		["ts_ls"] = function()
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
				-- Se você usa ESLint, pode desativar o linting do TS aqui para evitar duplicados
				-- settings = { content_assertion = false }
			})
		end,
	},
})

-- ========================================================================== --
--                                KEYMAPS                                     --
-- ========================================================================== --
local map = vim.keymap.set

-- Navegação e Geral
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>pv", ":Ex<CR>")
map("n", "J", "mzJ`z")
map("i", "<C-c>", "<Esc>")

-- Movimentação de blocos (Visual Mode)
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Clipboard e Deletar
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", '"_d')

-- Janelas
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")

-- Picker / Telescope
local builtin = require("telescope.builtin")
map("n", "<leader>F", ":Pick files<CR>")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)

-- LSP Keymaps
map("n", "<leader>f", function()
	vim.lsp.buf.format({ async = true })
end)
map("n", "<leader>rn", function()
	if not require("ts-autotag").rename() then
		vim.lsp.buf.rename()
	end
end)

-- Diagnósticos (API nativa Neovim 0.10+)
map("n", "[d", function()
	vim.diagnostic.jump({ count = -1, float = true })
end)
map("n", "]d", function()
	vim.diagnostic.jump({ count = 1, float = true })
end)

-- ========================================================================== --
--                                AUTOCMDS                                    --
-- ========================================================================== --
local group = vim.api.nvim_create_augroup("UserConfigs", { clear = true })

-- Highlight ao copiar
vim.api.nvim_create_autocmd("TextYankPost", {
	group = group,
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Format on Save
vim.api.nvim_create_autocmd("BufWritePre", {
	group = group,
	pattern = "*",
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
