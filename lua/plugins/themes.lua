function ColorMyPencils(color)
	color = color or "tokyonight"
	vim.cmd.colorscheme(color)

	-- Change the background color of the status line
	vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
	vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  vim.api.nvim_set_hl(0, "Pmenu", { bg = "none" })

end

return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		opts = { },
    config = function()
      ColorMyPencils()
    end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"luisiacc/gruvbox-baby",
	},
	{
		"Shatur/neovim-ayu",
		mirage = true,
	},
  {
    "rose-pine/neovim",
    name = "rose-pine",
    config = function()
      require('rose-pine').setup({
        disable_background = true,
        styles = {
          italic = false,
        },
      })
    ColorMyPencils()
    end,
  }
}
