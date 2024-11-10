return {
   'hrsh7th/nvim-cmp',
   event = 'InsertEnter',
   dependencies = {
      {"hrsh7th/cmp-buffer"},
      {'hrsh7th/cmp-nvim-lsp'},
      {"L3MON4D3/LuaSnip"},
      {'saadparwaiz1/cmp_luasnip'},
   },
   config = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      local select_opts = {behavior = cmp.SelectBehavior.Select}

      -- See :help cmp-config
      cmp.setup({
         snippet = {
            expand = function(args)
               luasnip.lsp_expand(args.body)
            end
         },
         sources = {
            {name = 'nvim_lsp'},
            {name = 'luasnip', keyword_length = 2},
            {name = 'buffer', keyword_length = 3},
         },
         -- TODO: style window
         --window = {
         --   completion = cmp.config.window.bordered(),
         --   documentation = cmp.config.window.bordered(),
         --},
         -- See :help cmp-mapping
         mapping = {
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
            ['<Down>'] = cmp.mapping.select_next_item(select_opts),

            ['<C-j>'] = cmp.mapping.select_next_item(select_opts),
            ['<C-k>'] = cmp.mapping.select_prev_item(select_opts),

            ['<C-u>'] = cmp.mapping.scroll_docs(-4),
            ['<C-d>'] = cmp.mapping.scroll_docs(4),

            ['<C-e>'] = cmp.mapping.abort(),
            ['<C-y>'] = cmp.mapping.confirm({select = true}),
            ['<CR>'] = cmp.mapping.confirm({select = false}),

            -- TODO: understand and improve Tab behavior
            ['<Tab>'] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_next_item()
               elseif luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
               else
                  fallback()
               end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
               if cmp.visible() then
                  cmp.select_prev_item()
               elseif luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
               else
                  fallback()
               end
            end, { 'i', 's' }),
         },
      })
   end
}
