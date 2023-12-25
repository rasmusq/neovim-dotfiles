vim.opt.number = true
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.mouse = ""
vim.opt.ignorecase = true

vim.opt.swapfile = false

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.diagnostic.config({
    virtual_text = true,
    virtual_lines = true,
    signs = false,
    float = {
        source = "always", -- Or "if_many"
    },
})
vim.diagnostic.config({ update_in_insert = true })

-- Highlight Yank
vim.cmd([[
augroup highlight_yank
autocmd!
au TextYankPost * silent! lua vim.highlight.on_yank({higroup="Search", timeout=200})
augroup END
]])
