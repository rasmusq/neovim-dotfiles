vim.opt.number = true
vim.opt.tabstop = 2      -- Number of spaces tabs count for
vim.opt.shiftwidth = 2   -- Number of spaces for autoindenting
vim.opt.softtabstop = 2  -- Number of spaces to use for a <Tab>
vim.opt.expandtab = true -- Use spaces instead of tabs
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
