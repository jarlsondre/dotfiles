vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Window movement
vim.keymap.set('n', '<leader>h', '<C-w>h', { noremap = true })
vim.keymap.set('n', '<leader>j', '<C-w>j', { noremap = true })
vim.keymap.set('n', '<leader>k', '<C-w>k', { noremap = true })
vim.keymap.set('n', '<leader>l', '<C-w>l', { noremap = true })

vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { noremap = true })

-- To change the size of the split in 15 point intervals
vim.keymap.set('n', '<leader>o', '15<C-w>>', { noremap = true })
vim.keymap.set('n', '<leader>y', '15<C-w><', { noremap = true })
vim.keymap.set('n', '<leader>i', '7<C-w>+', { noremap = true })
vim.keymap.set('n', '<leader>u', '7<C-w>-', { noremap = true })

-- Swap window positions
vim.keymap.set('n', '<leader>s', '<C-w>r', { noremap = true })
