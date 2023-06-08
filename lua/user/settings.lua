-- settings.lua

-- Global options
vim.opt.clipboard = "unnamedplus"     -- Use the system clipboard
vim.opt.mouse = "a"                   -- Enable mouse support
vim.opt.termguicolors = true          -- Enable 24-bit color support

-- Window-local options
vim.opt.number = true                 -- Show line numbers
vim.opt.relativenumber = true         -- Show relative line numbers
vim.opt.cursorline = true             -- Highlight the current line
vim.opt.wrap = false                  -- Disable line wrapping
vim.opt.scrolloff = 8                 -- Start scrolling 8 lines before edge
vim.opt.splitright = true             -- Open vertical splits to the right
vim.opt.splitbelow = true             -- Open horizontal splits below

-- Buffer-local options
vim.opt.expandtab = true              -- Use spaces instead of tabs
vim.opt.shiftwidth = 4                -- Indent by 4 spaces
vim.opt.tabstop = 4                   -- Set tab width to 4 spaces
vim.opt.smartindent = true            -- Auto-indent new lines
vim.opt.ignorecase = true             -- Ignore case when searching
vim.opt.smartcase = true              -- Don't ignore case with capital letters
vim.opt.updatetime = 300              -- Set faster update time
vim.opt.timeoutlen = 500              -- Set faster timeout for mappings
vim.opt.showmode = false              -- Don't show mode (use statusline)

-- Strip Trailing Whitespace
vim.cmd("autocmd! BufWritePre * %s/\\s\\+$//e")
