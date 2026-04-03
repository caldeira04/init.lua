-- ========================================================================== --
--                                  OPÇÕES                                    --
-- ========================================================================== --
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

-- ========================================================================== --
--                              BOOTSTRAP LAZY                                --
-- ========================================================================== --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- ========================================================================== --
--                                  PLUGINS                                   --
-- ========================================================================== --
require("lazy").setup({
    -- Interface
    { "oskarnurm/koda.nvim" },
    { "arnamak/stay-centered.nvim",     opts = {} },

    -- Edição
    { "windwp/nvim-autopairs",          opts = {} },
    { "kylechui/nvim-surround",         opts = {} },
    { "supermaven-inc/supermaven-nvim", opts = {} },

    -- Snippets
    {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        main = "nvim-treesitter",
        opts = {
            ensure_installed = {
                "html", "javascript", "typescript",
                "tsx", "vue", "lua", "vim", "vimdoc",
            },
            highlight = { enable = true },
            auto_install = true,
        },
    },

    -- Autocompletar
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
        },
        config = function()
            local cmp     = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<C-y>"]     = cmp.mapping.confirm({ select = true }),
                    ["<C-n>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<C-p>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                }, {
                    { name = "buffer" },
                }),
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol_text",
                        maxwidth = 50,
                        ellipsis_char = "...",
                    }),
                },
                window = {
                    completion    = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
            })
        end,
    },

    -- Mason (instalador de servidores)
    { "mason-org/mason.nvim",       opts = {} },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "mason-org/mason.nvim" },
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "vtsls",
                "vue-language-server",
            },
        },
    },

    -- Telescope / Picker
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    { "echasnovski/mini.pick",      opts = {} },

    -- Autotag
    { "tronikelis/ts-autotag.nvim", opts = {} },
})

-- ========================================================================== --
--                            COLORSCHEME                                     --
-- ========================================================================== --
require("koda").setup({ transparent = true })
vim.cmd("colorscheme koda")

-- ========================================================================== --
--                         LSP (API nativa 0.11)                              --
-- ========================================================================== --
local capabilities = require("cmp_nvim_lsp").default_capabilities()

local mason_data   = vim.fn.stdpath("data") .. "/mason"
local vue_ls_path  = mason_data .. "/packages/vue-language-server/node_modules/@vue/language-server"
local tsdk_path    = mason_data .. "/packages/typescript-language-server/node_modules/typescript/lib"

-- lua_ls
vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", "stylua.toml", ".git" },
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = { library = vim.api.nvim_get_runtime_file("", true) },
            telemetry = { enable = false },
        },
    },
})

-- vtsls com suporte a Vue via plugin
vim.lsp.config("vtsls", {
    capabilities = capabilities,
    cmd = { "vtsls", "--stdio" },
    filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "vue",
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = {
                    {
                        name = "@vue/typescript-plugin",
                        location = vue_ls_path,
                        languages = { "vue" },
                        configNamespace = "typescript",
                        enableForWorkspaceTypeScriptVersions = true,
                    },
                },
            },
        },
    },
})

-- vue_ls
vim.lsp.config("vue_ls", {
    capabilities = capabilities,
    cmd = { "vue-language-server", "--stdio" },
    filetypes = { "vue" },
    root_markers = { "package.json", ".git" },
    init_options = {
        typescript = { tsdk = tsdk_path },
    },
})

-- Ativa os servidores
vim.lsp.enable({ "lua_ls", "vtsls", "vue_ls" })

-- ========================================================================== --
--                                KEYMAPS                                     --
-- ========================================================================== --
local map = vim.keymap.set

-- Geral
map("n", "<Esc>", "<cmd>nohlsearch<CR>")
map("n", "<leader>pv", ":Ex<CR>")
map("n", "J", "mzJ`z")
map("i", "<C-c>", "<Esc>")

-- Visual: mover blocos
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Clipboard
map("x", "<leader>p", [["_dP]])
map({ "n", "v" }, "<leader>y", [["+y]])
map("n", "<leader>Y", [["+Y]])
map({ "n", "v" }, "<leader>d", '"_d')

-- Janelas
map("n", "<C-h>", "<C-w><C-h>")
map("n", "<C-l>", "<C-w><C-l>")
map("n", "<C-j>", "<C-w><C-j>")
map("n", "<C-k>", "<C-w><C-k>")

-- Telescope / Picker
local builtin = require("telescope.builtin")
map("n", "<leader>F", ":Pick files<CR>")
map("n", "<leader>ff", builtin.find_files)
map("n", "<leader>fg", builtin.live_grep)

-- LSP
map("n", "<leader>f", function()
    vim.lsp.buf.format({ async = true })
end)
map("n", "<leader>rn", function()
    if not require("ts-autotag").rename() then
        vim.lsp.buf.rename()
    end
end)

-- Diagnósticos
map("n", "[d", function() vim.diagnostic.jump({ count = -1, float = true }) end)
map("n", "]d", function() vim.diagnostic.jump({ count = 1, float = true }) end)

-- ========================================================================== --
--                                AUTOCMDS                                    --
-- ========================================================================== --
local group = vim.api.nvim_create_augroup("UserConfigs", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    group = group,
    callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    callback = function() vim.lsp.buf.format({ async = false }) end,
})
