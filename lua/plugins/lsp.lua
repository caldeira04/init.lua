return {
  "neoclide/coc.nvim",
  branch = "release",
  config = function()
    vim.g.coc_global_extensions = {
      "coc-json",
      "coc-tsserver",
      "coc-tailwindcss",
      "coc-html",
      "coc-css",
      "coc-lua",
      "coc-pairs",
      "coc-snippets",
      "coc-git",
      "coc-prettier",
    }
    vim.keymap.set("i", "<C-n>", function()
      if vim.fn["coc#pum#visible"]() == 1 then
        return vim.fn["coc#pum#next"](1)
      elseif vim.fn["CheckBackspace"]() then
        return "<leader>"
      else
        return vim.fn["coc#refresh"]()
      end
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-p>", function()
      return vim.fn["coc#pum#visible"]() == 1 and vim.fn["coc#pum#prev"](1) or "<C-h>"
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-y>", function()
      return vim.fn["coc#pum#visible"]() == 1 and vim.fn["coc#pum#confirm"]() or "<C-g>u<CR><c-r>=coc#on_enter()<CR>"
    end, { expr = true, silent = true })

    vim.keymap.set("i", "<C-Space>", "coc#refresh()", { expr = true, silent = true })

    -- Função CheckBackspace em Lua
    vim.fn["CheckBackspace"] = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") and 1 or 0
    end

    vim.keymap.set("n", "gd", "<Plug>(coc-definition)", { silent = true })
    vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
    vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", { silent = true })
    vim.keymap.set("n", "gr", "<Plug>(coc-references)", { silent = true })
    vim.keymap.set("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true })
    vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })
    vim.keymap.set("n", "<leader>ca", "<Plug>(coc-codeaction)", { silent = true })

    -- LSP related stuff
    vim.keymap.set("n", "[d", "<Plug>(coc-diagnostic-prev)", { desc = "Go to previous Diagnostic message" })
    vim.keymap.set("n", "]d", "<Plug>(coc-diagnostic-next)", { desc = "Go to next Diagnostic message" })
    vim.keymap.set("n", "<leader>e", ":CocList diagnostics<CR>", { desc = "Show diagnostic messages" })

    vim.keymap.set("n", "<leader>f", ":call CocActionAsync('format')<CR>", { desc = "Format current buffer" })
  end,
}
