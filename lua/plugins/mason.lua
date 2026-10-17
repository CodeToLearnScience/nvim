return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    lazy = false,
    opts = {
      -- Use Mason package names, rather than LSP configuration names.
      ensure_installed = {
        "typescript-language-server",
        "rust-analyzer",
        "lua-language-server",
        "stylua",
        "prettier",
        "codelldb",
        "js-debug-adapter",
      },
      run_on_start = true,
      start_delay = 3000,
      auto_update = false,
      integrations = {
        ["mason-lspconfig"] = false,
        ["mason-null-ls"] = false,
        ["mason-nvim-dap"] = false,
      },
    },
  },
}
