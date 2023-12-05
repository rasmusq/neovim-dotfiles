-- Keybindings
vim.g.mapleader = " "
vim.api.nvim_set_keymap("c", "mg", "<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "mg", "<esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "mg", "<esc>", { noremap = true, silent = true })

-- Make indenting in visual mode keep the selection
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Paste from system clipboard
vim.api.nvim_set_keymap("n", "<leader>p", '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>P", '"+P', { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>Y", '"+Y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<leader>Y", '"+Y', { noremap = true, silent = true })

-- Redo
vim.api.nvim_set_keymap("n", "U", "<cmd>redo<cr>", { noremap = true, silent = true })

-- Escape Terminal
vim.api.nvim_set_keymap("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Open Terminal
vim.api.nvim_set_keymap("n", "<leader>Q", "<cmd>!blackbox -w $PWD<cr>", { noremap = true, silent = true })
