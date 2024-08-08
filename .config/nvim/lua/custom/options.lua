-- Line numbers and UI
vim.o.number = true
vim.o.numberwidth = 2
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true

vim.o.scrolloff = 10

-- Tab and spaces
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.wrap = false
vim.o.tabstop = 3
vim.o.shiftwidth = 3

-- Enable mouse mode
vim.o.mouse = 'a'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Search
vim.o.hlsearch = false
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true
