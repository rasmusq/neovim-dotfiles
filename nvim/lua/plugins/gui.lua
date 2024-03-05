return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.o.timeout = true
            vim.o.timeoutlen = 300
        end,
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
        },
    },
    {
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            -- OR 'ibhagwan/fzf-lua',
            "nvim-tree/nvim-web-devicons",
        },
        config = function(_, opts)
            require("octo").setup(opts)
        end,
    },
    {
        "dgagn/diagflow.nvim",
        event = "LspAttach",
        opts = {
            -- placement = "inline",
            inline_padding_left = 3,
        },
    },
    {
        "gelguy/wilder.nvim",
        config = function(_, opts)
            local wilder = require("wilder")
            wilder.setup({ modes = { ":", "/", "?" } })
        end,
    },
    {
        "sindrets/diffview.nvim",
    },
    -- {
    --     "rcarriga/nvim-notify",
    --     opts = { stages = "static", render = "compact" },
    --     config = function(_, opts)
    --         require("notify").setup(opts)
    --         vim.notify = require("notify")
    --         vim.keymap.set("n", "<leader>fn", "<cmd>Telescope notify<cr>", {})
    --     end,
    -- },
    -- TODO: Try when nvim is 0.10
    -- {
    --     "Bekaboo/dropbar.nvim",
    --     -- optional, but required for fuzzy finder support
    --     dependencies = {
    --         "nvim-telescope/telescope-fzf-native.nvim",
    --     },
    -- },
    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        },
        config = function(_, opts)
            vim.keymap.set("n", "<leader>t", "<cmd>Neotree<cr>", {})
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "nvim-telescope/telescope-frecency.nvim",
            "debugloop/telescope-undo.nvim",
            "dawsers/telescope-file-history.nvim",
        },
        config = function()
            require("telescope").load_extension("frecency")
            require("telescope").load_extension("undo")
            require("file_history").setup({
                -- This is the location where it will create your file history repository
                backup_dir = "~/.file-history-git",
                -- command line to execute git
                git_cmd = "git",
            })
            require("telescope").load_extension("file_history")
            require("telescope").setup({
                defaults = {
                    border = false,
                    -- layout_config = {
                    --     vertical = { width = 1000 },
                    --     horizontal = { width = 1000, height = 1000 },
                    -- },
                    file_ignore_patterns = {
                        ".git",
                    },
                },
                pickers = {
                    find_files = {
                        hidden = true,
                    },
                    live_grep = {
                        additional_args = function()
                            return { "--hidden" }
                        end,
                    },
                },
                extensions = {
                    frecency = {
                        show_scores = false,
                        show_unindexed = true,
                        disable_devicons = false,
                    },
                },
            })
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<Leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<Leader>fC", builtin.commands, {})
            vim.keymap.set("n", "<Leader>fh", "<cmd>Telescope file_history history<cr>", {})
            vim.keymap.set("n", "<Leader>fr", "<cmd>Telescope frecency<cr>", {})
            vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<Leader>fH", builtin.help_tags, {})
            vim.keymap.set("n", "<Leader>fs", builtin.lsp_document_symbols, {})
            vim.keymap.set("n", "<Leader>fS", builtin.lsp_dynamic_workspace_symbols, {})
            vim.keymap.set("n", "<Leader>fT", builtin.treesitter, {})
            vim.keymap.set("n", "<Leader>fD", builtin.diagnostics, {})
            vim.keymap.set("n", "<Leader>fd", function()
                builtin.diagnostics({ bufnr = 0 })
            end, {})
            vim.keymap.set("n", "<Leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<Leader>fl", builtin.git_status, {})
            vim.keymap.set("n", "<Leader>fm", builtin.marks, {})
            vim.keymap.set("n", "<Leader>fa", builtin.git_branches, {})
            vim.keymap.set("n", "<Leader>fc", builtin.git_commits, {})
            vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>")
            vim.keymap.set("n", "<Leader>fi", builtin.lsp_implementations, {})
        end,
    },
    {
        "kepano/flexoki-neovim",
        name = "flexoki",
        config = function(_, opts)
            -- vim.cmd("colorscheme flexoki-dark")
            vim.api.nvim_create_autocmd({ "CursorMoved" }, {
                callback = function()
                    vim.cmd("highlight StatusLine guibg=NONE")
                    vim.cmd("highlight StatusLineNC guibg=NONE")
                    vim.cmd("highlight VertSplit guifg=bg")
                    vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
                    vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
                end,
            })
        end,
    },
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 100,
            set_dark_mode = function()
                vim.api.nvim_set_option("background", "dark")
                vim.cmd("colorscheme flexoki-dark")
            end,
            set_light_mode = function()
                vim.api.nvim_set_option("background", "light")
                vim.cmd("colorscheme flexoki-light")
            end,
        },
    },
}
