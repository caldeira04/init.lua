local vue_plugin = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server/node_modules/@vue/typescript-plugin"

---@type vim.lsp.Config
return {
    cmd = { "typescript-language-server", "--stdio" },
    init_options = {
        hostInfo = "neovim",
        plugins = {
            {
                name = "@vue/typescript-plugin",
                location = vue_plugin,
                languages = { "javascript", "typescript", "vue" },
            },
        },
    },
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
    },
    root_markers = {
        "tsconfig.json",
        "jsconfig.json",
        "package.json",
        ".git",
    },
}
