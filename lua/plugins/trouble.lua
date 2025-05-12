return {
	{
		"folke/trouble.nvim",
		opts = {},
		cmd = "Trouble",
    keys = {
      { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Trouble" },
      { "<leader>[d", "<cmd>Trouble diagnostics prev<cr>", desc = "Trouble" },
      { "<leader>]d", "<cmd>Trouble diagnostics next<cr>", desc = "Trouble" },
      { "<leader>q", "<cmd>Trouble qflist toggle<cr>", desc = "Trouble" },
    }
	},
}
