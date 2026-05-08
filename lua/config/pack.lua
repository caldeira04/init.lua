vim.pack.add({
    { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
    'https://github.com/vinitkumar/fff.nvim',
    'https://github.com/tronikelis/ts-autotag.nvim',
    'https://github.com/windwp/nvim-autopairs',
    'https://github.com/kylechui/nvim-surround',
    'https://github.com/arnamak/stay-centered.nvim',
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('>=1.0.0') },
    'https://github.com/rafamadriz/friendly-snippets',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/mason-org/mason.nvim',
    'https://github.com/mason-org/mason-lspconfig.nvim',
    'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
})

require("fff").setup({
    build = 'cargo build --release'
})

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("stay-centered").setup()

vim.cmd("packadd nvim.undotree")
