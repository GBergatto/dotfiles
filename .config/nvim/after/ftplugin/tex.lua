local opts = { noremap = true, silent = true }

-- lauch zathura on current pdf
vim.api.nvim_buf_set_keymap(0, "n", "<leader>p", ":!zathura %:r.pdf & <CR>", opts)

-- save file and compile latex
vim.api.nvim_buf_set_keymap(0, "n", "<F5>", ":w <CR> :!xelatex % <CR>", opts)

vim.o.shiftwidth = 2
