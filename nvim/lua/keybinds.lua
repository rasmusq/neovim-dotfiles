-- Keybindings
vim.g.mapleader = " "

-- Make indenting in visual mode keep the selection
vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Paste from system clipboard
vim.keymap.set("n", "<leader>p", '"+p', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>P", '"+P', { noremap = true, silent = true })

vim.keymap.set("n", "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set("v", "<leader>Y", '"+Y', { noremap = true, silent = true })

-- Redo
vim.keymap.set("n", "U", "<cmd>redo<cr>", { noremap = true, silent = true })

-- Escape Terminal
vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })

-- Open Terminal
vim.api.nvim_set_keymap("n", "<leader>Q", "<cmd>!blackbox -w $PWD<cr>", { noremap = true, silent = true })
