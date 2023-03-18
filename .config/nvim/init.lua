-- Config from DT
-- https://gitlab.com/dwt1/dotfiles/-/blob/master/.config/nvim/init.lua
-- https://github.com/numToStr/dotfiles/tree/master/neovim/.config/nvim/

require "gb.options"
require "gb.colorscheme"
require "gb.keymaps"
require "gb.plugins"
require "gb.cmp"
require "gb.lsp"
require "gb.autopairs"
require "gb.telescope"
require "gb.treesitter"

require('lualine').setup()

-- Highlight the region on yank
vim.api.nvim_create_autocmd('TextYankPost', {
    group = num_au,
    callback = function()
        vim.highlight.on_yank({ higroup = 'Visual', timeout = 120 })
    end,
})

