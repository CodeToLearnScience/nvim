local M = {}

function M.check()
  vim.health.start("Neovim development configuration")
  if vim.fn.has("nvim-0.12") == 1 then
    vim.health.ok("Neovim 0.12+ is available")
  else
    vim.health.error("Neovim 0.12+ is required by the configured Tree-sitter branch")
  end

  vim.health.start("External executables")
  for _, command in ipairs({ "git", "rg", "fd", "node", "npm", "cargo", "rustc", "rustfmt", "cc", "curl", "tar", "tree-sitter" }) do
    local path = vim.fn.exepath(command)
    if path ~= "" then
      vim.health.ok(command .. ": " .. path)
    else
      vim.health.warn(command .. " is missing from Neovim's PATH; see README prerequisites")
    end
  end
  if vim.fn.executable("tree-sitter") == 1 then
    local result = vim.system({ "tree-sitter", "--version" }, { text = true }):wait(5000)
    local version = result.stdout and result.stdout:match("(%d+%.%d+%.%d+)")
    if result.code == 0 and version and vim.version.ge(version, "0.26.1") then
      vim.health.ok("Tree-sitter CLI " .. version)
    else
      vim.health.error("Tree-sitter CLI 0.26.1+ is required; check tree-sitter --version")
    end
  end

  vim.health.start("Configured Mason tools")
  local ok, registry = pcall(require, "mason-registry")
  if ok then
    local specs = require("plugins.mason")
    for _, name in ipairs(specs[2].opts.ensure_installed) do
      local found, pkg = pcall(registry.get_package, name)
      if found and pkg:is_installed() then
        vim.health.ok(name .. " is installed")
      else
        vim.health.warn(name .. " is missing; run :MasonToolsInstall and inspect :MasonLog")
      end
    end
  else
    vim.health.warn("Mason is not available yet; finish plugin installation")
  end

  vim.health.start("Running language servers")
  local clients = vim.lsp.get_clients()
  if #clients == 0 then
    vim.health.info("No language servers are running; open a project source file to start one")
  else
    for _, client in ipairs(clients) do
      vim.health.ok("Attached language server: " .. client.name)
    end
  end
  vim.health.info("Use :ConformInfo in a source buffer for formatter selection and availability")
  vim.health.info("ESLint and test frameworks must also be installed in each project")
end

return M
