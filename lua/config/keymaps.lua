vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", {
	desc = "Save file",
})

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", {
	desc = "Quit",
})

-- Windows and splits. Keep <leader>w available for saving.
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

vim.keymap.set("n", "<leader>sv", "<cmd>vsplit<cr>", { desc = "Split vertically" })
vim.keymap.set("n", "<leader>sh", "<cmd>split<cr>", { desc = "Split horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Equalize window sizes" })
vim.keymap.set("n", "<leader>sc", "<cmd>close<cr>", { desc = "Close window" })

vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })

-- Buffer deletion uses :bdelete so unsaved changes are protected.
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>buffer #<cr>", { desc = "Alternate buffer" })
vim.keymap.set("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })

vim.keymap.set("n", "<leader>co", "<cmd>copen<cr>", { desc = "Open quickfix results" })
vim.keymap.set("n", "<leader>cc", "<cmd>cclose<cr>", { desc = "Close quickfix results" })
vim.keymap.set("n", "]q", "<cmd>cnext<cr>", { desc = "Next quickfix result" })
vim.keymap.set("n", "[q", "<cmd>cprevious<cr>", { desc = "Previous quickfix result" })
vim.keymap.set("n", "<leader>cp", "<cmd>colder<cr>", { desc = "Previous quickfix list" })
vim.keymap.set("n", "<leader>cn", "<cmd>cnewer<cr>", { desc = "Newer quickfix list" })

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { buffer = event.buf, desc = "Go to implementation" })
        vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { buffer = event.buf, desc = "Go to type definition" })
		vim.keymap.set("n", "K", vim.lsp.buf.hover, {
			buffer = event.buf,
			desc = "LSP hover",
		})

		vim.keymap.set("n", "gd", vim.lsp.buf.definition, {
			buffer = event.buf,
			desc = "Go to definition",
		})

		vim.keymap.set("n", "gr", vim.lsp.buf.references, {
			buffer = event.buf,
			desc = "Find references",
		})

		vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, {
			buffer = event.buf,
			desc = "Rename symbol",
		})

		vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, {
			buffer = event.buf,
			desc = "Code action",
		})

	end,
})

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, {
	desc = "Previous diagnostic",
})

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, {
	desc = "Next diagnostic",
})

vim.keymap.set("n", "<leader>ld", vim.diagnostic.open_float, {
	desc = "Show diagnostic",
})

vim.keymap.set("n", "<leader>du", function()
	require("dapui").toggle()
end, {
	desc = "Toggle debugger UI",
})

-- Debugging
vim.keymap.set("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Toggle breakpoint" })

vim.keymap.set("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Start / continue debugging" })

vim.keymap.set("n", "<leader>dn", function()
	require("dap").step_over()
end, { desc = "Step over" })

vim.keymap.set("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Step into" })

vim.keymap.set("n", "<leader>do", function()
	require("dap").step_out()
end, { desc = "Step out" })

vim.keymap.set("n", "<leader>dt", function()
	require("dap").terminate()
end, { desc = "Terminate debugging" })
