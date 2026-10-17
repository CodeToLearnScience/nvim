return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      settings = {
        key = function()
          return vim.fn.getcwd()
        end,
        save_on_toggle = true,
        sync_on_ui_close = true,
      },
    },
    keys = {
      { "<leader>ma", function() require("harpoon"):list():add() end, desc = "Bookmark file" },
      { "<leader>mm", function()
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, desc = "Edit project bookmarks" },
      { "<leader>mn", function() require("harpoon"):list():next() end, desc = "Next bookmark" },
      { "<leader>mp", function() require("harpoon"):list():prev() end, desc = "Previous bookmark" },
      { "<leader>m1", function() require("harpoon"):list():select(1) end, desc = "Bookmark 1" },
      { "<leader>m2", function() require("harpoon"):list():select(2) end, desc = "Bookmark 2" },
      { "<leader>m3", function() require("harpoon"):list():select(3) end, desc = "Bookmark 3" },
      { "<leader>m4", function() require("harpoon"):list():select(4) end, desc = "Bookmark 4" },
    },
  },
}
