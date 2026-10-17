return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",

    config = function()
      local treesitter = require("nvim-treesitter")
      treesitter.setup({})

      local function start_highlighting(buf)
        if not vim.api.nvim_buf_is_loaded(buf) or vim.bo[buf].buftype ~= "" then
          return
        end

        -- A parser may still be downloading, or the filetype may be unsupported.
        pcall(vim.treesitter.start, buf)
      end

      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("ConfigTreesitter", { clear = true }),
        callback = function(event)
          start_highlighting(event.buf)
        end,
      })

      treesitter.install({
        "javascript",
        "typescript",
        "tsx",
        "rust",
        "lua",
        "vim",
        "vimdoc",
        "query",
      }):await(function()
        vim.schedule(function()
          for _, buf in ipairs(vim.api.nvim_list_bufs()) do
            start_highlighting(buf)
          end
        end)
      end)
    end,
  },
}
