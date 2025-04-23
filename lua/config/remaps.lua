-- Keymaps
-- End highlight when searching
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Best remap ever; allows you to shift lines placement
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Movement and navigation
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv") -- Move linha pra baixo em visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv") -- Move linha pra cima em visual mode
vim.keymap.set("n", "J", "mzJ`z")            -- Junta linhas mas mantém cursor na posição original
vim.keymap.set("n", "<C-d>", "<C-d>zz")      -- Desce a tela e centraliza
vim.keymap.set("n", "<C-u>", "<C-u>zz")      -- Sobe a tela e centraliza
vim.keymap.set("n", "n", "nzzzv")            -- Vai pro próximo match e centraliza
vim.keymap.set("n", "N", "Nzzzv")            -- Vai pro anterior match e centraliza

-- LSP related stuff
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous Diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next Diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic Error messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic Quickfix list" })

-- Yanking and pasting
vim.keymap.set("x", "<leader>p", [["_dP]])         -- Cola sem sobrescrever o clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]]) -- Yank pro sistema
vim.keymap.set("n", "<leader>Y", [["+Y]])
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")  -- Delete sem mandar pro clipboard

-- Multi-window stuff
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Personal keybinds; everything is pretty much described
vim.keymap.set("n", "<leader>pv", ":Ex<CR>", { desc = "Open Netrw in current folder", silent = true }) -- Opens Netrw
vim.keymap.set("n", "<leader>sn", ":Ex " .. vim.fn.stdpath("config") .. "<CR>",
  { desc = "Open Neovim config folder", silent = true })
vim.keymap.set("n", "<leader>t", ":cd %:p:h<CR>:term<CR>",
  { desc = "Open terminal in current Netrw dir", noremap = true, silent = true })
vim.keymap.set("n", "<leader>S", ":cd %:p:h<CR>", { desc = "Shift current working dir", noremap = true, silent = true })
vim.keymap.set("i", "<C-c>", "<Esc>", { desc = "Exit insert mode" })                   -- Exit insert mode
vim.keymap.set("n", "<leader><leader>", ":so %<CR>", { desc = "Source current file" }) -- Source current file

-- Vim fugitive
vim.keymap.set("n", "<leader>gc", ":Git commit<CR>", { desc = "Git commit" })
vim.keymap.set("n", "<leader>gp", ":Git push<CR>", { desc = "Git push" })
vim.keymap.set("n", "<leader>gP", ":Git pull<CR>", { desc = "Git pull" })
vim.keymap.set("n", "<leader>ga", ":Git add %<CR>", { desc = "Git add" })
vim.keymap.set("n", "<leader>gA", ":Git add .<CR>", { desc = "Git add all" })
vim.keymap.set("n", "<leader>gq", "<cmd>q<CR>", { desc = "Close message" })
vim.keymap.set("n", "<leader>gl", function()
  vim.cmd("Git blame")
end, { desc = "Open git log" })
vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "Open git status" })
vim.keymap.set("n", "<leader>gS", require("telescope.builtin").git_stash, { desc = "Open git stash" })

vim.keymap.set("n", "<leader>gb", function()
  local actions = require("telescope.actions")
  local action_state = require("telescope.actions.state")
  local telescope = require("telescope")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  pickers.new({}, {
    prompt_title = "Git Checkout",
    finder = finders.new_oneshot_job(
      { "git", "branch", "--all", "--format=%(refname:short)" },
      {}
    ),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(_, map)
      map("i", "<CR>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd("Git checkout " .. selection[1])
      end)

      map("i", "<C-n>", function(prompt_bufnr)
        actions.close(prompt_bufnr)
        vim.ui.input({ prompt = "New branch name: " }, function(input)
          if input and input ~= "" then
            vim.cmd("Git checkout -b " .. input)
          end
        end)
      end)

      map("i", "<C-d>", function(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        if not selection then return end
        actions.close(prompt_bufnr)

        local branch = selection[1]
        vim.ui.select({ "Yes", "No " }, {
          prompt = "delete branch " .. branch .. "?",
        }, function(choice)
          if choice == "Yes" then
            if branch:match("^remotes/") then
              vim.notify("Não dá pra deletar branch remota localmente, animal 🐒", vim.log.levels.ERROR)
            else
              vim.cmd("Git branch -D " .. branch)
            end
          end
        end)
      end)

      return true
    end
  }):find()
end)
