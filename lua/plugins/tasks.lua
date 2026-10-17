local function cargo_task(command)
  local root = vim.fs.root(0, { "Cargo.toml" })
  if not root then
    vim.notify("No Cargo.toml found for this buffer", vim.log.levels.WARN)
    return
  end
  vim.cmd("update")
  local overseer = require("overseer")
  local task = overseer.new_task({
    name = "cargo " .. command,
    cmd = { "cargo", command },
    cwd = root,
    components = { "default" },
  })
  task:start()
  overseer.open()
end

return {
  {
    "stevearc/overseer.nvim",
    opts = {},
    cmd = { "OverseerRun", "OverseerToggle", "OverseerTaskAction" },
    keys = {
      {
        "<leader>rr",
        function()
          vim.cmd("update")
          local root = vim.fs.root(0, { "Cargo.toml", "package.json", ".git" }) or vim.fn.getcwd()
          require("overseer").run_task({ cwd = root, search_params = { dir = root } })
        end,
        desc = "Select project task or npm script",
      },
      { "<leader>ro", "<cmd>OverseerToggle<cr>", desc = "Toggle task list" },
      { "<leader>ra", "<cmd>OverseerTaskAction<cr>", desc = "Task actions (rerun / stop / output)" },
      { "<leader>rc", function() cargo_task("check") end, desc = "Cargo check" },
      { "<leader>rb", function() cargo_task("build") end, desc = "Cargo build" },
      { "<leader>rt", function() cargo_task("test") end, desc = "Cargo test" },
    },
  },
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    init = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#start_normal"] = 1
    end,
    keys = {
      { "<leader>Tn", "<cmd>update<bar>TestNearest<cr>", desc = "Run nearest test" },
      { "<leader>Tf", "<cmd>update<bar>TestFile<cr>", desc = "Run tests in file" },
      { "<leader>Ts", "<cmd>update<bar>TestSuite<cr>", desc = "Run test suite" },
      { "<leader>Tl", "<cmd>update<bar>TestLast<cr>", desc = "Rerun last test" },
      { "<leader>Tv", "<cmd>TestVisit<cr>", desc = "Visit last test file" },
    },
  },
}
