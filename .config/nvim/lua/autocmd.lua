-- [[ Highlight on yank ]]
-- See `:help vim.highligh .on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ higroup = 'Visual', timeout = 150 })
  end,
  group = highlight_group,
  pattern = '*',
})
