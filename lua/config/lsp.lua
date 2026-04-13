local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config['lua_ls'] = {
    cmd = { 'lua-language-server' },
    capabilities = capabilities,
    diagnostics = { globals = { 'vim' } },
    filetypes = { 'lua' },
    root_markers = { { '.luarc.json', '.luarc.jsonc' }, '.git' },
}

vim.lsp.config['vtsls'] = {
    cmd = { "vtsls", "--stdio" },
    capabilities = capabilities,
    filetypes = {
        "javascript", "javascriptreact",
        "typescript", "typescriptreact",
        "vue"
    },
    root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" }
}

vim.lsp.enable({ 'lua_ls', 'vtsls' })
