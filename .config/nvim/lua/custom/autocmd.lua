-- Format dart on save 
vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("dart_formatter", { clear = true }),
  pattern = "*.dart",
  callback = function ()
    -- https://neovim.io/doc/user/lsp.html#vim.lsp.buf.format()
    vim.lsp.buf.format { async = false }
  end
})
