return {
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },

  -- properly configure LuaLS for editing your Neovim config
  {
     "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },

  --{
  --   "zenbones-theme/zenbones.nvim",
  --   dependencies = "rktjmp/lush.nvim",
  --   lazy = false,
  --},

  --{
  --   "ellisonleao/gruvbox.nvim",
  --   -- TODO: make colors more like base16-gruvbox-dark-hard
  --   priority = 1000,
  --   opts = {
  --      contrast = "hard", -- Can be "hard", "medium", or "soft"
  --      transparent_mode = false,
  --   },
  --   config = function()
  --      vim.cmd.colorscheme 'gruvbox'
  --   end,
  --},

  --{
  --   "rose-pine/neovim",
  --},

  --{
  --   "nyoom-engineering/oxocarbon.nvim",
  --},

  --{
  --  'RRethy/nvim-base16',
  --  --priority = 1000,
  --  --config = function()
  --  --  vim.cmd.colorscheme 'base16-tokyo-city-dark'
  --  --end,
  --},

  {
    -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'auto', -- load from console scheme
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  {
     'goerz/jupytext.nvim',
     opts = {},
  },

}
