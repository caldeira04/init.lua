vim.pack.add({
    { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
    'https://github.com/vinitkumar/fff.nvim',
    'https://github.com/tronikelis/ts-autotag.nvim',
    'https://github.com/windwp/nvim-autopairs',
    'https://github.com/kylechui/nvim-surround',
    'https://github.com/arnamak/stay-centered.nvim',
})

require("fff").setup({
    build = 'cargo build --release'
})

require("nvim-surround").setup()
require("nvim-autopairs").setup()
require("stay-centered").setup()

vim.cmd("packadd nvim.undotree")
