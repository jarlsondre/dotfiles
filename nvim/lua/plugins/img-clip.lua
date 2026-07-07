return {
  "HakonHarnes/img-clip.nvim",
  event = "VeryLazy",
  cond = not require("util.env").in_ssh(), -- pasting images from the clipboard is a local-only workflow
  opts = {
    -- add options here
    -- or leave it empty to use the default settings
  },
  keys = {
    -- suggested keymap
    { "<leader>pi", "<cmd>PasteImage<cr>", desc = "Paste image from system clipboard" },
  },
}
