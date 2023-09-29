local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- 'wbthomason/packer.nvim',
  'ellisonleao/gruvbox.nvim',

  --colorschemes
  'rebelot/kanagawa.nvim',
  {
    'dracula/vim',
    lazy = false,
  },
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },

  { 'rose-pine/neovim', name = 'rose-pine' },

  'nvim-tree/nvim-tree.lua',
  'nvim-tree/nvim-web-devicons',
  'nvim-lualine/lualine.nvim',
  'nvim-treesitter/nvim-treesitter',
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.2',
    dependencies = { {'nvim-lua/plenary.nvim'} }
  },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
  --LSP
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'L3MON4D3/LuaSnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-buffer',
      --'hrsh7th/cmp-cmdline',
      'saadparwaiz1/cmp_luasnip',
    },
  }
}

local opts = {}

require("lazy").setup(plugins, opts)
