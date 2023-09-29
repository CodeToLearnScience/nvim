-------------------------------------------------------------------------------
--Auto commands
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- User variables
-------------------------------------------------------------------------------

local augroup = vim.api.nvim_create_augroup -- Create auto group
local autocmd = vim.api.nvim_create_autocmd -- Create auto command

-------------------------------------------------------------------------------
--General auto commands
-------------------------------------------------------------------------------

-- Highlight on yank
augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  callback = function()
    vim.highlight.on_yank({ higroup = 'IncSearch', timeout = '1000' })
  end
})

-- Don't auto comment new lines
autocmd('BufEnter', {
  pattern = '',
  command = 'set fo-=c fo-=r fo-=o'
})


-------------------------------------------------------------------------------
-- Terminal 
-------------------------------------------------------------------------------

-- Open a Terminal on the right tab
autocmd('CmdlineEnter', {
  command = 'command! Term :botright vsplit term://$SHELL'
})

-- Enter insert mode when switching to terminal
autocmd('TermOpen', {
  command = 'setlocal listchars= nonumber norelativenumber nocursorline',
})

autocmd('TermOpen', {
  pattern = '',
  command = 'startinsert'
})

-- Close terminal buffer on process exit
autocmd('BufLeave', {
  pattern = 'term://*',
  command = 'stopinsert'
})
