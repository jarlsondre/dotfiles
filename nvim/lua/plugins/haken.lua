return {
  "lineick/haken.nvim",
  config = function()
    require("haken").setup({
      -- column_sensitive = false, -- update haken even when just the column changed
      clear_jumplist = true,    -- clear jumplist on VimEnter (start of your session)
    })
  end,
}
