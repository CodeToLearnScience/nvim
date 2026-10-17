return {
	"stevearc/conform.nvim",
	event = "BufWritePre",
	cmd = { "ConformInfo" },
	keys = {
		{
			"<leader>lf",
			function()
				require("conform").format({ async = true })
			end,
			mode = { "n", "x" },
			desc = "Format buffer or selection",
		},
	},
	opts = {
		default_format_opts = {
			lsp_format = "fallback",
		},
		notify_no_formatters = true,
		formatters_by_ft = {
			lua = { "stylua" },
			rust = { "rustfmt" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			html = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
		},
	},
}
