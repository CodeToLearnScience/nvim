return {
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Review Git changes / conflicts" },
      { "<leader>gc", "<cmd>DiffviewClose<cr>", desc = "Close Git review" },
      { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "Git project history" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "Git file history" },
      {
        "<leader>gb",
        function()
          vim.ui.input({ prompt = "Compare revision (e.g. origin/main...HEAD): " }, function(revision)
            if revision and revision ~= "" then
              vim.api.nvim_cmd({ cmd = "DiffviewOpen", args = { revision } }, {})
            end
          end)
        end,
        desc = "Compare Git revision",
      },
    },
    config = function()
      local actions = require("diffview.actions")
      require("diffview").setup({
        use_icons = false,
        -- Avoid buffer-local leader mappings shadowing our existing groups.
        keymaps = {
          disable_defaults = true,
          view = {
            { "n", "<Tab>", actions.select_next_entry, { desc = "Next changed file" } },
            { "n", "<S-Tab>", actions.select_prev_entry, { desc = "Previous changed file" } },
            { "n", "<leader>gp", actions.focus_files, { desc = "Focus Git file panel" } },
            { "n", "]x", actions.next_conflict, { desc = "Next conflict" } },
            { "n", "[x", actions.prev_conflict, { desc = "Previous conflict" } },
            { "n", "<leader>gO", actions.conflict_choose("ours"), { desc = "Choose ours" } },
            { "n", "<leader>gT", actions.conflict_choose("theirs"), { desc = "Choose theirs" } },
          },
          file_panel = {
            { "n", "j", actions.next_entry },
            { "n", "k", actions.prev_entry },
            { "n", "<CR>", actions.select_entry },
            { "n", "<Tab>", actions.select_next_entry },
            { "n", "<S-Tab>", actions.select_prev_entry },
          },
          file_history_panel = {
            { "n", "j", actions.next_entry },
            { "n", "k", actions.prev_entry },
            { "n", "<CR>", actions.select_entry },
            { "n", "<Tab>", actions.select_next_entry },
            { "n", "<S-Tab>", actions.select_prev_entry },
          },
        },
      })
    end,
  },
}
