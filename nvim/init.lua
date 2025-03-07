require("config")
require("autoclose").setup()

-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- basic stuff
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.smarttab = true

vim.opt.breakindent = true
vim.opt.updatetime = 250

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- highlight search
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.scrolloff = 10
vim.opt.colorcolumn = "88"

-- These options are handled by the neoscroll plugin now
vim.opt.scroll = 15
-- vim.keymap.set("n", "L", "<C-d>zz", {desc = "Center cursor after moving down half-page"})
-- vim.keymap.set("n", "H", "<C-u>zz", {desc = "Center cursor after moving up half-page"})

-- Allow search terms to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Allowing you to comment and uncomment using Comment.nvim
local comment_api = require("Comment.api")
local esc = vim.api.nvim_replace_termcodes('<ESC>', true, false, true)

-- line comment
vim.keymap.set("n", "<C-Space>",
  function()
    comment_api.toggle.linewise.current()
  end, { noremap = true, silent = true }
)
-- visual mode comment
vim.keymap.set('x', '<C-Space>',
  function()
    vim.api.nvim_feedkeys(esc, 'nx', false)
    comment_api.toggle.linewise(vim.fn.visualmode())
  end
)

-- Making option + backspace work as "delete previuos word"
vim.keymap.set('i', '<M-BS>', "<C-W>")

-- Adding venv for python black
vim.g.python3_host_prog = vim.fn.expand("~/.config/nvim/.venv/bin/python")

-- Adding line numbers in netrw
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

local gitsigns = require("gitsigns")
vim.keymap.set("n", "<leader>tb",
  function()
    gitsigns.toggle_current_line_blame()
  end
)

-- Formatting
local conform = require("conform")
vim.keymap.set("n", "<leader>fmt", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 2000,
  })
end, { desc = "Format file" }
)
require("luasnip.loaders.from_snipmate").load()
