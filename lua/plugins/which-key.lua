return {
  {
    "folke/which-key.nvim",
    event = "VeryLazy",

    opts = {
      spec = {
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
