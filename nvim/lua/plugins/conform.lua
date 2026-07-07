return {
  "stevearc/conform.nvim",
  config = function()
    local conform = require("conform")
    conform.setup({
      formatters_by_ft = {
        lua = { "stylua" },
        -- conform will run multiple formatters sequentially
        python = { "ruff_format" },
        -- you can customize some of the format options for the filetype (:help conform.format)
        rust = { "rustfmt", lsp_format = "fallback" },
        -- Note: tex files are formatted by texlab (latexindent) via the lsp fallback below
      },
    })

    vim.keymap.set({"n", "x"}, "<leader>fmt", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 2000,
      })
    end, { desc = "format file current file with 'conform' plugin" }
    )
  end,
}
