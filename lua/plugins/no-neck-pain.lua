return {
  {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    lazy = false,

    keys = {
      {
        "<leader>z",
        "<cmd>NoNeckPain<cr>",
        desc = "Toggle centered layout",
      },
    },

    opts = {
      width = 120,

      autocmds = {
        -- Center the text on startup; "safe" waits for session restore and `nvim +line file`.
        enableOnVimEnter = "safe",
        enableOnTabEnter = true,
      },
    },
  },
}
