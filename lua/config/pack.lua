vim.pack.add({
    { src = 'https://github.com/rose-pine/neovim', name = 'rose-pine' },
     'https://github.com/vinitkumar/fff.nvim'
})

require("fff").setup({
    build = 'cargo build --release'
})
