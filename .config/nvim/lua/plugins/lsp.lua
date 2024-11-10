local function on_attach(_, bufnr)
   -- Helper function for creating keymaps
   local nmap = function(keys, func, desc)
      if desc then
         desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
   end

   nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
   nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

   local t_builtin = require('telescope.builtin')
   nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
   nmap('gr', t_builtin.lsp_references, '[G]oto [R]eferences')
   nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
   nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
   nmap('<leader>ds', t_builtin.lsp_document_symbols, '[D]ocument [S]ymbols')
   nmap('<leader>ws', t_builtin.lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

   -- See `:help K` for why this keymap
   nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
   nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

   -- Lesser used LSP functionality
   nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
   nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
   nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
   nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
   end, '[W]orkspace [L]ist Folders')
end

local settings = {
   lua_ls = {
      Lua = {
         -- Get the LPS server to recognize the 'vim' global
         diagnostics = { globals = { "vim" } },
      },
   }
}

return {
   {
      "neovim/nvim-lspconfig",
   },
   {
      "williamboman/mason.nvim",
      opts = {
         ui = {border = 'rounded'},
      }
   },
   {
      "williamboman/mason-lspconfig.nvim",
      dependencies = { "mason.nvim", "hrsh7th/cmp-nvim-lsp" },
      config = function()
         local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
         local lspconfig = require("lspconfig")

         -- See :help mason-lspconfig-settings
         require('mason-lspconfig').setup({
            ensure_installed = {},
            handlers = {
               -- See :help mason-lspconfig-dynamic-server-setup
               function(server_name)
                  -- See :help lspconfig-setup
                  lspconfig[server_name].setup({
                     capabilities = lsp_capabilities,
                     on_attach = on_attach,
                     settings = settings[server_name],
                  })
               end,
            }
         })
      end
   }
}

