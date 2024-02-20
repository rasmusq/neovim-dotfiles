return {
    {
        "aserowy/tmux.nvim",
        config = function()
            return require("tmux").setup()
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
    {
        "altermo/ultimate-autopair.nvim",
        event = { "InsertEnter", "CmdlineEnter" },
        branch = "v0.6", --recomended as each new version will have breaking changes
        opts = {
            space = { enable = true },
            --Config goes here
        },
    },
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
        "folke/todo-comments.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {
            signs = false,
            keywords = {
                FIX = {
                    icon = "",
                    color = "error",
                    alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
                },
                TODO = { icon = "", color = "info" },
                HACK = { icon = "", color = "warning" },
                WARN = { icon = "", color = "warning", alt = { "WARNING", "XXX" } },
                PERF = { icon = "", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
                NOTE = { icon = "", color = "hint", alt = { "INFO" } },
                TEST = { icon = "", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
            },
        },
        config = function(_, opts)
            require("todo-comments").setup(opts)
            vim.keymap.set("n", "<Leader>ft", "<cmd>TodoTelescope<cr>", {})
        end,
    },
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
