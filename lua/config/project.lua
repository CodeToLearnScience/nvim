vim.api.nvim_create_user_command("ProjectRoot", function()
  local root = vim.fs.root(0, { "package.json", "Cargo.toml", ".git" })

  if root then
    print(root)
  else
    print("Project root not found")
  end
end, {})

vim.api.nvim_create_user_command("ConfigHealth", function()
  vim.cmd("checkhealth config")
end, { desc = "Check development tools and configured Mason packages" })
