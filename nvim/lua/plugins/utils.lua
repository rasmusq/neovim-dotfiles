return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {}, -- This causes the plugin setup function to be called
    keys = {
        { "<C-Down>", "<Cmd>MultipleCursorsAddDown<CR>", mode = { "n", "i" } },
        { "<C-j>", "<Cmd>MultipleCursorsAddDown<CR>" },
        { "<C-Up>", "<Cmd>MultipleCursorsAddUp<CR>", mode = { "n", "i" } },
        { "<C-k>", "<Cmd>MultipleCursorsAddUp<CR>" },
        { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>", mode = { "n", "i" } },
        { "<Leader>a", "<Cmd>MultipleCursorsAddMatches<CR>", mode = { "n", "x" } },
        { "<Leader>A", "<Cmd>MultipleCursorsAddMatchesV<CR>", mode = { "n", "x" } },
        { "<Leader>d", "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } },
        { "<Leader>D", "<Cmd>MultipleCursorsJumpNextMatch<CR>" },
        { "<Leader>l", "<Cmd>MultipleCursorsLockToggle<CR>", mode = { "n", "x" } },
    },
    {
        "aserowy/tmux.nvim",
        opts = {
            copy_sync = {
                redirect_to_clipboard = true,
            },
        },
        config = function(_, opts)
            return require("tmux").setup(opts)
        end,
    },
    {
        "gbprod/substitute.nvim",
        opts = {},
        config = function(_, opts)
            require("substitute").setup(opts)
            -- Substitute (imitates the ReplaceWithRegister vim bindings in ideavim)
            vim.keymap.set("n", "gr", require("substitute").operator, { noremap = true })
            vim.keymap.set("n", "grr", require("substitute").line, { noremap = true })
            vim.keymap.set("n", "Rg", require("substitute").eol, { noremap = true })
            vim.keymap.set("x", "gr", require("substitute").visual, { noremap = true })

            -- Exchange (imitates the exchange vim bindings in ideavim)
            vim.keymap.set("n", "cx", require("substitute.exchange").operator, { noremap = true })
            vim.keymap.set("n", "cxx", require("substitute.exchange").line, { noremap = true })
            vim.keymap.set("x", "X", require("substitute.exchange").visual, { noremap = true })
            vim.keymap.set("n", "cxc", require("substitute.exchange").cancel, { noremap = true })
        end,
    },
    --{
    --    "altermo/ultimate-autopair.nvim",
    --    event = { "InsertEnter", "CmdlineEnter" },
    --    branch = "v0.6", --recomended as each new version will have breaking changes
    --    opts = {
    --        space = { enable = true },
    --        --Config goes here
    --    },
    --},
    {
        "BartSte/nvim-project-marks",
        lazy = false,
        opts = { mappings = false, message = "Input mark..." },
        config = function(_, opts)
            require("projectmarks").setup(opts)
        end,
    },
    {
        "chentoast/marks.nvim",
        opts = {
            force_write_shada = true,
        },
        config = function(_, opts)
            require("marks").setup(opts)
        end,
    },
    {
        "rmagatti/auto-session",
        opts = {
            log_level = "error",
            auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
            buftypes_to_ignore = { "neo-tree" },
        },
        config = function(_, opts)
            require("auto-session").setup(opts)
        end,
    },
    { "tpope/vim-commentary" },
    { "echasnovski/mini.surround", version = false, opts = {} },
    {
        "HiPhish/rainbow-delimiters.nvim",
        opts = function()
            local rainbow_delimiters = require("rainbow-delimiters")
            return {
                strategy = {
                    [""] = rainbow_delimiters.strategy["global"],
                    vim = rainbow_delimiters.strategy["local"],
                },
                query = {
                    [""] = "rainbow-delimiters",
                    lua = "rainbow-blocks",
                },
                highlight = {
                    "RainbowDelimiterYellow",
                    "RainbowDelimiterBlue",
                    "RainbowDelimiterOrange",
                    "RainbowDelimiterGreen",
                    "RainbowDelimiterViolet",
                    "RainbowDelimiterCyan",
                    -- "RainbowDelimiterRed",
                },
            }
        end,
        config = function(_, opts)
            require("rainbow-delimiters.setup").setup(opts)
        end,
    },
}
