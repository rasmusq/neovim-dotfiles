vim.g.mapleader = " "

if vim.g.neovide then
    vim.g.neovide_floating_shadow = true
    vim.g.neovide_floating_z_height = 10
    vim.g.neovide_light_angle_degrees = 45
    vim.g.neovide_light_radius = 5
    vim.g.neovide_floating_blur_amount_x = 2.0
    vim.g.neovide_floating_blur_amount_y = 2.0

    vim.api.nvim_win_set_option(0, "winblend", 10)
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

vim.opt.number = true
vim.opt.tabstop = 2 -- Number of spaces tabs count for
vim.opt.shiftwidth = 2 -- Number of spaces for autoindenting
vim.opt.softtabstop = 2 -- Number of spaces to use for a <Tab>
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.mouse = ""
vim.opt.ignorecase = true
vim.o.showtabline = 0

vim.opt.swapfile = false

-- Set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.diagnostic.config({
    virtual_text = {
        severity = { min = vim.diagnostic.severity.ERROR },
    },
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
