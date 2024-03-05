-- Keybindings
vim.api.nvim_set_keymap("c", "mg", "<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "mg", "<esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "mg", "<esc>", { noremap = true, silent = true })

-- Make indenting in visual mode keep the selection
-- vim.api.nvim_set_keymap("v", "<", "<gv", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", ">", ">gv", { noremap = true, silent = true })

-- Redo
vim.api.nvim_set_keymap("n", "U", "<cmd>redo<cr>", { noremap = true, silent = true })

local wk = require("which-key")
wk.register({
    w = { "<cmd>w<cr>", "write buffer" },
    q = { "<cmd>q<cr>", "quit buffer" },
    p = { '"+p', "paste system clipboard under line" },
    P = { '"+P', "paste system clipboard over line" },
    y = { '"+p', "copy selection to system clipboard" },
    Y = { '"+P', "copy lines to system clipboard" },
}, { prefix = "<leader>" })
