return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  config = function()
    vim.api.nvim_set_hl(0, "IblScope", { fg = "#00FFFF", bg = "#000000" })
    require("ibl").setup {
      indent = {
        char = "│",
      },
      scope = {
        enabled = true,
        char = "│",
        highlight = { "IblScope" },
      },
      exclude = {
        filetypes = { "help", "alpha", "dashboard", "lazy", "mason" },
        buftypes = { "terminal" },
      },
    }
  end,
}
