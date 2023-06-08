-- keymaps.lua

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

vim.g.mapleader = " "

-- Better Exploring
map("n", "<leader>pv", ":Explore<CR>")

-- Faster saving
map("n", "<leader>w", ":w<CR>")

-- Faster quitting
map("n", "<leader>q", ":q<CR>")


-- Toggle highlight searching
map("n", "<leader>h", ":set hlsearch!<CR>")

-- Better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move selected lines up and down
map("v", "K", ":move '<-2<CR>gv-gv")
map("v", "J", ":move '>+1<CR>gv-gv")

-- Yank to the end of line
map("n", "Y", "y$")
