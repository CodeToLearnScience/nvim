return {
  {
    "neovim/nvim-lspconfig",

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "mason-org/mason.nvim",
    },

    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.lsp.config("ts_ls", {
        capabilities = capabilities,
      })

      vim.lsp.config("rust_analyzer", {
        capabilities = capabilities,
      })

      vim.lsp.enable("ts_ls")
      vim.lsp.enable("rust_analyzer")
    end,
  },
}
