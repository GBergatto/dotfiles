local opts = { noremap = true, silent = true }

vim.o.tabstop = 2
vim.o.shiftwidth = 2

-- Run file
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<CR>:!gcc -o %:r % && ./%:r <CR>", opts)

-- Format and save
vim.api.nvim_buf_set_keymap(0, "n", "<F4>", ":Format<CR>:w<CR>", opts)
