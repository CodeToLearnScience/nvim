return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = function()
      require("nvim-treesitter-textobjects").setup({
        select = { lookahead = true },
        move = { set_jumps = true },
      })

      for key, capture in pairs({
        af = "@function.outer", ["if"] = "@function.inner",
        ac = "@class.outer", ic = "@class.inner",
        aa = "@parameter.outer", ia = "@parameter.inner",
      }) do
        vim.keymap.set({ "x", "o" }, key, function()
          require("nvim-treesitter-textobjects.select").select_textobject(capture, "textobjects")
        end, { desc = "Select " .. capture })
      end

      for key, move in pairs({
        ["]m"] = { "goto_next_start", "@function.outer" },
        ["[m"] = { "goto_previous_start", "@function.outer" },
        ["]M"] = { "goto_next_end", "@function.outer" },
        ["[M"] = { "goto_previous_end", "@function.outer" },
        ["]c"] = { "goto_next_start", "@class.outer" },
        ["[c"] = { "goto_previous_start", "@class.outer" },
      }) do
        vim.keymap.set({ "n", "x", "o" }, key, function()
          require("nvim-treesitter-textobjects.move")[move[1]](move[2], "textobjects")
        end, { desc = move[1] .. " " .. move[2] })
      end
    end,
  },
}
