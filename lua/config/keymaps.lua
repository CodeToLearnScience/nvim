vim.g.mapleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", {
	desc = "Save file",
})

vim.keymap.set("n", "<leader>q", "<cmd>q<cr>", {
	desc = "Quit",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
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

		vim.keymap.set("n", "<leader>lf", function()
			require("conform").format({
				async = true,
				lsp_format = "fallback",
			})
		end, {
			buffer = event.buf,
			desc = "Format buffer",
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
