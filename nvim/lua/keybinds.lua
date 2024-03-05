vim.api.nvim_set_keymap("c", "mg", "<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("i", "mg", "<esc>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "mg", "<esc>", { noremap = true, silent = true })

vim.api.nvim_set_keymap("n", "U", "<cmd>redo<cr>", { noremap = true, silent = true })

local wk = require("which-key")
wk.register({
    s = { "<cmd>w<cr>", "Write buffer" },
    q = { "<cmd>q<cr>", "Quit buffer" },
    w = { "<cmd>bd<cr>", "Unload buffer" },
    p = { '"+p', "Paste system clipboard under line" },
    P = { '"+P', "Paste system clipboard over line" },
    y = { '"+p', "Copy selection to system clipboard" },
    Y = { '"+P', "Copy lines to system clipboard" },
    d = {
        name = "Diagnostics",
        d = { vim.diagnostic.open_float, "Open float" },
        e = { vim.diagnostic.goto_prev, "Goto prev" },
        n = { vim.diagnostic.goto_next, "Goto next" },
    },
}, { prefix = "<leader>" })
