require "keymaps"
require "autocmd"
require "options"
require "config.lazy"

vim.cmd.colorscheme("retrobox")

-- TODO: move to lua/config/lsp.lua

-- Enable servers found in ~/.config/lsp/ directory
vim.lsp.enable({
   "lua_ls",
   "clangd",
   "pyrefly",
   "jdtls",
   "svlangserver",
})

-- from https://youtu.be/tdhxpn1XdjQ
vim.api.nvim_create_autocmd("LspAttach", {
   callback = function (ev)
      local client = vim.lsp.get_client_by_id(ev.data.client_id)
      if client:supports_method("textDocument/completion") then
         vim.opt.completeopt = {"menu", "menuone", "noinsert", "fuzzy", "popup"}
         vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
         vim.keymap.set("i", "<C-Space>", function() vim.lsp.completion.get() end)
      end
   end
})

-- Diagnostics
vim.diagnostic.config({
   virtual_text = {
      current_line = true,
      virt_text_pos = "eol",
   },
})

