-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Set <Leader> to space
vim.g.mapleader = " "
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

-- Functional wrapper for mapping custom keybindings
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<Leader>lf", ":lua vim.lsp.buf.format({async=true})<CR>") -- Format Code
map("n", "<Leader>ff", ":Telescope find_files<CR>") -- Find Files in cwd
map("n", "<Leader>rf", ":Telescope oldfiles<CR>") -- Recent Files

-- Indentation
map("v", "<", "<gv")
map("n", "<", "v<")
map("v", ">", ">gv")
map("n", ">", "v>")

-- Move lines
map("n", "K", "5k")
map("n", "J", "5j")
map("n", "k", "kzz")
map("n", "j", "jzz")
map("v", "K", ":m-2<CR>gv=gv")
map("v", "J", ":m'>+<CR>gv=gv")

-- Increment/decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Delete a word backwards
keymap.set("n", "dw", 'vb"_d')

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")
-- keymap.set("n", "<D-a>", "gg<S-v>G")

-- Save
keymap.set("n", "<C-s>", ":w<CR>")

-- Copy
keymap.set("v", "<C-c>", "y")

-- Jumplist
keymap.set("n", "<C-m>", "<C-i>", opts)

-- New tab
keymap.set("n", "te", ":tabedit")
keymap.set("n", "<tab>", ":tabnext<Return>", opts)
keymap.set("n", "<s-tab>", ":tabprev<Return>", opts)
-- Split window
keymap.set("n", "ss", ":split<Return>", opts)

keymap.set("n", "sv", ":vsplit<Return>", opts)
-- Move window
keymap.set("n", "sh", "<C-w>h")
keymap.set("n", "sk", "<C-w>k")
keymap.set("n", "sj", "<C-w>j")
keymap.set("n", "sl", "<C-w>l")

-- Resize window
keymap.set("n", "w<left>", "<C-w><")
keymap.set("n", "w<right>", "<C-w>>")
keymap.set("n", "w<up>", "<C-w>+")
keymap.set("n", "w<down>", "<C-w>-")
-- custom command to open config
vim.cmd(":command! Config e ~/.config/nvim/")
