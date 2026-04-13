vim.pack.add({
    { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
    'https://github.com/vinitkumar/fff.nvim',
    'https://github.com/tronikelis/ts-autotag.nvim',
    'https://github.com/windwp/nvim-autopairs',
    'https://github.com/kylechui/nvim-surround',
    'https://github.com/arnamak/stay-centered.nvim',
    { src = 'https://github.com/saghen/blink.cmp', version = vim.version.range('>=1.0.0') },
    'https://github.com/rafamadriz/friendly-snippets'
})

require("fff").setup({
    build = 'cargo build --release'
})

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("stay-centered").setup()

vim.cmd("packadd nvim.undotree")

require('blink.cmp').setup({
    keymap = { preset = 'default' },
    appearance = {
        nerd_font_variant = "mono",
    },
    sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' }
    },
    fuzzy = { implementation = 'lua' },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 200 }
    }
})
