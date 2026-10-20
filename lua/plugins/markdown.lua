return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.icons",
      "nvim-tree/nvim-web-devicons",
    },

    keys = {
      { "<leader>M", "<cmd>RenderMarkdown toggle<cr>", ft = "markdown", desc = "Toggle markdown rendering" },
    },

    opts = {
      -- Show raw markdown on the cursor line so it stays editable.
      anti_conceal = { enabled = true },
      completions = { lsp = { enabled = true } },
    },
  },
}
