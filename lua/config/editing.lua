local group = vim.api.nvim_create_augroup("ConfigEditing", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function()
    vim.hl.on_yank({ timeout = 150 })
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  group = group,
  callback = function(event)
    if vim.bo[event.buf].buftype ~= "" or vim.bo[event.buf].filetype == "gitcommit" then
      return
    end
    local mark = vim.api.nvim_buf_get_mark(event.buf, '"')
    if mark[1] > 1 and mark[1] <= vim.api.nvim_buf_line_count(event.buf) then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

vim.keymap.set("x", "<", "<gv", { desc = "Indent left and keep selection" })
vim.keymap.set("x", ">", ">gv", { desc = "Indent right and keep selection" })
