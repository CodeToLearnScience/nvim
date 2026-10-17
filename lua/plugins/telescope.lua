local function search_root()
  return vim.fs.root(0, { ".git" })
    or vim.fs.root(0, { "Cargo.toml", "package.json" })
    or vim.fn.getcwd()
end

return {
	{
		"nvim-telescope/telescope.nvim",

		dependencies = {
			"nvim-lua/plenary.nvim",
		},

        opts = {
          defaults = {
            mappings = {
              i = {
                ["<C-q>"] = function(prompt_bufnr)
                  local actions = require("telescope.actions")
                  actions.smart_send_to_qflist(prompt_bufnr)
                  actions.open_qflist(prompt_bufnr)
                end,
              },
              n = {
                ["<C-q>"] = function(prompt_bufnr)
                  local actions = require("telescope.actions")
                  actions.smart_send_to_qflist(prompt_bufnr)
                  actions.open_qflist(prompt_bufnr)
                end,
              },
            },
          },
        },
		keys = {
          {
            "<leader>fw",
            function()
              require("telescope.builtin").grep_string({ cwd = search_root(), word_match = "-w" })
            end,
            desc = "Search word in project",
          },
          {
            "<leader>fG",
            function()
              require("telescope.builtin").git_files({ cwd = search_root(), show_untracked = false })
            end,
            desc = "Find Git-tracked files",
          },
          {
            "<leader>fd",
            function()
              local root = search_root()
              vim.ui.input({ prompt = "Search directory: ", default = root .. "/", completion = "dir" }, function(dir)
                if not dir or dir == "" then return end
                dir = vim.fn.fnamemodify(vim.fn.expand(dir), ":p")
                if vim.fn.isdirectory(dir) == 0 then
                  vim.notify("Directory does not exist: " .. dir, vim.log.levels.WARN)
                  return
                end
                require("telescope.builtin").live_grep({ cwd = dir })
              end)
            end,
            desc = "Search chosen directory",
          },
          {
            "<leader>li",
            function() require("telescope.builtin").lsp_incoming_calls() end,
            desc = "Incoming calls",
          },
          {
            "<leader>lo",
            function() require("telescope.builtin").lsp_outgoing_calls() end,
            desc = "Outgoing calls",
          },
			{
				"<leader>ff",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Find files",
			},

			{
				"<leader>fg",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Live grep",
			},

			{
				"<leader>fb",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Find buffers",
			},

			{
				"<leader>fr",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "Recent files",
			},

			{
				"<leader>fh",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Help tags",
			},

			{
				"<leader>lD",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				desc = "LSP definitions",
			},

			{
				"<leader>lR",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "LSP references",
			},

			{
				"<leader>ls",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "Document symbols",
			},

			{
				"<leader>lS",
				function()
					require("telescope.builtin").lsp_workspace_symbols()
				end,
				desc = "Workspace symbols",
			},
		},
	},
}
