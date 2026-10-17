return {
  {
    "MagicDuck/grug-far.nvim",
    opts = {},
    cmd = { "GrugFar" },
    keys = {
      {
        "<leader>fR",
        function()
          local root = vim.fs.root(0, { ".git" })
            or vim.fs.root(0, { "Cargo.toml", "package.json" })
            or vim.fn.getcwd()
          require("grug-far").open({ prefills = { paths = vim.fn.fnameescape(root) } })
        end,
        desc = "Project search and replace",
      },
    },
  },
}
