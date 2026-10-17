return {
	{
		"mfussenegger/nvim-dap",

		config = function()
			local function project_root()
				local file = vim.api.nvim_buf_get_name(0)

				return vim.fs.root(file, {
					"package.json",
					"Cargo.toml",
					".git",
				}) or vim.fn.getcwd()
			end

			local dap = require("dap")

			dap.adapters.codelldb = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",

				executable = {
					command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
					args = {
						"--port",
						"${port}",
					},
				},
			}
			dap.configurations.rust = {
				{
					name = "Launch Rust program",
					type = "codelldb",
					request = "launch",

					program = function()
						return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
					end,

					cwd = "${workspaceFolder}",
					stopOnEntry = false,
				},
			}

			-- JavaScript / TypeScript debug adapter
			local js_debug = vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js"

			dap.adapters["pwa-node"] = {
				type = "server",
				host = "127.0.0.1",
				port = "${port}",

				executable = {
					command = "node",
					args = {
						js_debug,
						"${port}",
					},
				},
			}
			dap.configurations.javascript = {
				{
					name = "Launch JavaScript file",
					type = "pwa-node",
					request = "launch",

					program = "${file}",
					cwd = "${workspaceFolder}",

					console = "integratedTerminal",
				},
			}

			dap.configurations.typescript = {
				{
					name = "Launch TypeScript",
					type = "pwa-node",
					request = "launch",

					program = function()
						return vim.fn.input("JavaScript executable: ", project_root() .. "/dist/", "file")
					end,

					cwd = project_root,

					sourceMaps = true,

					outFiles = function()
						return {
							project_root() .. "/**/*.js",
							"!**/node_modules/**",
						}
					end,

					console = "integratedTerminal",
					resolveSourceMapLocations = {
						"${workspaceFolder}/**",
					},
					trace = true,
					stopOnEntry = true,
				},
			}
		end,
	},
	{
		"nvim-neotest/nvim-nio",
	},

	{
		"rcarriga/nvim-dap-ui",

		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},

		opts = {},
	},
}
