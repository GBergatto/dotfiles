local opts = { noremap = true, silent = true }

-- Run file
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w<CR>:!gcc -o %:r % && ./%:r <CR>", opts)
-- Sanitize memory: -g –fsanitize=address
