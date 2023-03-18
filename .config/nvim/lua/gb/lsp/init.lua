local servers = {
    "sumneko_lua",
    "tsserver",
    "pyright",
    "clangd",
    -- "bashls",
    "jsonls",
    -- "yamlls",
}

local opts = { noremap = true, silent = true }
local buffopt = { noremap = true, silent = true, buffer = 0 }

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, buffopt)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buffopt)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, buffopt)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, buffopt)
    -- vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, buffopt)
    -- vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, buffopt)
    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, buffopt)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buffopt)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, buffopt)
    -- vim.keymap.set('n', 'gr', vim.lsp.buf.references, buffopt)
    -- vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = servers,
    automatic_installation = true,
})

require('lspconfig')['pyright'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['tsserver'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['sumneko_lua'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
require('lspconfig')['clangd'].setup {
    on_attach = on_attach,
    flags = lsp_flags,
}
