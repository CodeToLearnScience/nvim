return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
      spec = {
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
