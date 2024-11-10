-- Line numbers and UI
vim.o.number = true
vim.o.numberwidth = 3
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.cursorline = true

vim.o.scrolloff = 10 --999

vim.o.termguicolors = true

-- Tab and spaces
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.cindent = true
vim.o.autoindent = true
vim.o.wrap = false
vim.o.tabstop = 3
vim.o.shiftwidth = 3

vim.o.splitbelow = true
vim.o.splitbelow = true

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
vim.o.inccommand = "split"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

vim.o.virtualedit = "block"

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

