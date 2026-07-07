-- Loaded but disabled by default: turn it on with :Hardtime toggle (or enable)
-- when you want to practice proper vim movements.
-- Note: hardtime defers its setup by ~500ms, so the command isn't available
-- during the very first moments after startup.
return {
  "m4xshen/hardtime.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim" },
  opts = { enabled = false },
}
