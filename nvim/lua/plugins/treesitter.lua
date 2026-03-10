return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "rust" },
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
      }
    end,
  }
}
