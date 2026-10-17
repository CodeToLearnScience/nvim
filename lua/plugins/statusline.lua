return {
  {
    "nvim-lualine/lualine.nvim",

    event = "VeryLazy",

    opts = {
      sections = {
        lualine_a = { "mode" },

        lualine_b = {
          "branch",
          "diagnostics",
        },

        lualine_c = {
          "filename",
        },

        lualine_x = {
          "lsp_status",
          "filetype",
        },

        lualine_y = {
          "progress",
        },

        lualine_z = {
          "location",
        },
      },
    },
  },
}
