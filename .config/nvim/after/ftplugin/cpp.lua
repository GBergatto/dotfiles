local opts = { noremap = true, silent = true }

-- Run file reading input from "input.txt"
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":!g++ -fsanitize=address -std=c++17 -Wall % -o %:r && ./%:r <input.txt <CR>", opts)
