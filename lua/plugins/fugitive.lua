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

return {
  'tpope/vim-fugitive',
}

