return {
  {
    "akinsho/toggleterm.nvim",

    version = "*",

    keys = {
      {
        "<leader>t",
        "<cmd>ToggleTerm<cr>",
        desc = "Toggle terminal",
      },
    },

    opts = {
      direction = "horizontal",
      size = 15,
    },
  },
}
