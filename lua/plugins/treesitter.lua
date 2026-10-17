return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    opts = {
      ensure_installed = {
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "lua",
        "vim",
        "vimdoc",
        "query",
      },
    },
  },
}
