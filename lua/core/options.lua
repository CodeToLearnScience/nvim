--Copied and inspired from a lot of people's github repos(.dotfiles, nvim, etc)

-------------------------------------------------------------------------------
-- Variables definitions
-------------------------------------------------------------------------------
local g = vim.g 	-- Global variable
local opt = vim.opt 	-- Option variable

-------------------------------------------------------------------------------
-- For tree
opt.termguicolors = true
-------------------------------------------------------------------------------
-- Neovim options
-------------------------------------------------------------------------------
opt.number = true			--Show line number	
opt.ruler = true      --Show cursor position all the time 
opt.colorcolumn = '80'		    	              --Color bar at 80th column
opt.splitright = true		      	              --New window to right	
opt.splitbelow = true		      	              --New window to bottom
--opt.linebreak = true		      	            --Wrap on word boundary
opt.mouse = 'a'               		            --Enable mouse support
opt.clipboard = 'unnamedplus' 		            --Copy/paste to system clipboard 
opt.swapfile = false 		       	              --Don't save swapfile (annoying)
opt.completeopt = 'menuone,noinsert,noselect' --Autocomlete options
opt.scrolloff = 18    -- minimal number of screen lines to keep above and below the cursor
opt.sidescrolloff = 3 -- minimal number of screen columns to keep to the left and right (horizontal) of the cursor if wrap is `false`

-------------------------------------------------------------------------------
-- Tab, spaces, indent
-------------------------------------------------------------------------------
opt.expandtab = true 		  --Use spaces instead of tabs
opt.shiftwidth = 2 		    --Shift 2 spaces when tab
opt.tabstop = 2			      --Inser 2 spaces for each tab
opt.autoindent = true		--Auto indent
opt.smartindent = true		--Auto indent
opt.shiftround = true

-------------------------------------------------------------------------------
--Search, edit 
-------------------------------------------------------------------------------
opt.ignorecase=true --Ignore case while searching
opt.listchars = {  -- see hidden chars and their colors
    tab = "| ",
    eol = '¬',
    trail = '·'
}
-- Set up automatic spell checking
vim.opt.spelllang = 'en'
vim.opt.spell = true

