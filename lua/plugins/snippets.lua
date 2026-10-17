return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },

  {
    "saadparwaiz1/cmp_luasnip",
  },

  {
    "rafamadriz/friendly-snippets",
  },
}
