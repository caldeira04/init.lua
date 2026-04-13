local group = vim.api.nvim_create_augroup("UserConfigs", { clear = true })
local autocmd = vim.api.nvim_create_autocmd

autocmd("TextYankPost", {
    group = group,
    callback = function() vim.highlight.on_yank() end,
})

autocmd("BufWritePre", {
    group = group,
    pattern = "*",
    callback = function() vim.lsp.buf.format({ async = false }) end,
})
