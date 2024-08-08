-- Show line after desired maximum text width
vim.opt_local.colorcolumn = '89'

local opts = { noremap = true, silent = true }

-- Run file
vim.api.nvim_buf_set_keymap(0, 'n', '<F5>', ':wa<CR>:!python %:r.py<CR>', opts)

