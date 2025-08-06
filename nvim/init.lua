require("config")
require("autoclose").setup()
require("luasnip.loaders.from_snipmate").load() -- moved from the bottom, make sure still works

-- Check if current session is on SSH or running locally
vim.g.is_ssh = require("util.env").in_ssh()

-- Basic stuff
vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.textwidth = 95

-- Don't automatically wrap when going over the textwidth
vim.opt.formatoptions:remove('t')

vim.opt.breakindent = true
vim.opt.updatetime = 250

-- vim clipboard uses your system clipboard
vim.opt.clipboard = "unnamedplus"

-- Make the tabline always visible
vim.o.showtabline = 2

-- Making option + backspace work as "delete previuos word"
vim.keymap.set('i', '<M-BS>', "<C-W>")

-- Adding line numbers in netrw
vim.g.netrw_bufsettings = "noma nomod nu nobl nowrap ro"

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- highlight search
vim.opt.hlsearch = true
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.opt.scrolloff = 10

-- Create a column that shows when you've reached 95 characters
vim.opt.colorcolumn = "95"

-- Allow search terms to stay in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- To make searches (e.g. /search) and increment searches (e.g. :%s/old/new) more contrastive
vim.api.nvim_set_hl(0, 'Search', {
  fg = '#000000',
  bg = '#ffff5f',
  bold = true,
})
vim.api.nvim_set_hl(0, 'IncSearch', {
  fg = '#ffffff',
  bg = '#ff005f',
  bold = true,
})

-- To make clipboard work on SSH
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
    ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
  },
  paste = {
    ['+'] = require('vim.ui.clipboard.osc52').paste('+'),
    ['*'] = require('vim.ui.clipboard.osc52').paste('*'),
  },
}


-- Preview images in oil
vim.api.nvim_create_user_command("MacOSQuicklook", function()
  local oil = require("oil")
  local entry = oil.get_cursor_entry()

  local full_path
  if entry then
    full_path = vim.fs.joinpath(oil.get_current_dir(), entry.name)
  else
    -- Fallback to full path of current buffer
    full_path = vim.fn.expand("%:p")
  end

  vim.fn.jobstart({
    "osascript",
    "-e",
    string.format([[tell application "Finder" to open POSIX file "%s"]], full_path),
  }, { detach = true })
  -- vim.fn.jobstart({ "qlmanage", "-p", full_path }, { detach = true })
  -- vim.fn.jobstart({ "open", "-a", "Preview", full_path }, { detach = true })
end, {})
