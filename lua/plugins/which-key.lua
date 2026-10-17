return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
      spec = {
        { "<leader>g", group = "Git review" },
        { "<leader>m", group = "Bookmarks" },
        { "<leader>r", group = "Run tasks" },
        { "<leader>T", group = "Tests" },
        { "<leader>p", group = "Sessions" },
        { "<leader>c", group = "Quickfix" },
        { "<leader>s", group = "Splits" },
        { "<leader>b", group = "Buffers" },
        {
          "<leader>f",
          group = "Find",
        },

        {
          "<leader>l",
          group = "LSP",
        },

        {
          "<leader>h",
          group = "Git hunk",
        },

        { 
          "<leader>d", 
          group = "Debug" 
        },
      },
    },
  },
}
