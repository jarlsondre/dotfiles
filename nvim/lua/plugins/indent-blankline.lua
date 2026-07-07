return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  tag = "v3.8.2",
  config = function()
    require("ibl").setup({
      indent = { char = "▏"},
      scope = { enabled = false },
    })
  end,
}
