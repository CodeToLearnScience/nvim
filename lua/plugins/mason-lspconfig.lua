return {
  {
    "neovim/nvim-lspconfig",

    config = function()
      vim.lsp.enable("ts_ls")
      vim.lsp.enable("rust_analyzer")
    end,
  },
}
