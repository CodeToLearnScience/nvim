require("mason").setup()

local servers = { 'fortls', 'bashls', 'pyright', 'clangd', 'html', 'julials'}

require("mason-lspconfig").setup({
  ensure_installed = servers
})

local lsp_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lsp_status_ok then
  return
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
local root_dir = function()
  return vim.fn.getcwd()
end

--LSP servers 

local on_attach = function() 
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {buffer=0})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {buffer=0})
  vim.keymap.set('n', 'gtd', vim.lsp.buf.type_definition, {buffer=0})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {buffer=0})
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, {buffer=0})
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {buffer=0})
  
  vim.keymap.set('n', '<leader>fd', vim.diagnostic_goto_next, {buffer=0})
  vim.keymap.set('n', '<leader>pd', vim.diagnostic_goto_prev, {buffer=0})
end

require'lspconfig'.fortls.setup{
    cmd = {
        'fortls',
        '--lowercase_intrisics',
        '--hover_signature',
        '--hover_language=fortran',
        '--use_signature_help'
    }
}

--For all the servers on_attach 
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = root_dir,
    flags = {
      -- default in neovim 0.7+
      debounce_text_changes = 150,
    }
  }
end

