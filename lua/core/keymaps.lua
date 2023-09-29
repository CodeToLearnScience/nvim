-------------------------------------------------------------------------------
-- Keymaps for Neovim and plugins
-------------------------------------------------------------------------------

-- Function to define keymaps

local function map(mode, lhs, rhs, opts)
  local options = { noremap=true, silent=true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end


-- Disable arrow keys
map('', '<up>', '<nop>')
map('', '<down>', '<nop>')
map('', '<left>', '<nop>')
map('', '<right>', '<nop>')

--set leader key to space
vim.g.mapleader=' '

--map('n', '<leader>w', '<cmd>write<cr>')
map('n', '<leader>h', ':nohlsearch<CR>') --clear recent search



