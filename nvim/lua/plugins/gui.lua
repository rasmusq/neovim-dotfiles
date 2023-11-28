return {
    {
        "sindrets/diffview.nvim",
    },
    -- {
    --     "rcarriga/nvim-notify",
    --     opts = { stages = "fade" },
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
        "akinsho/toggleterm.nvim",
        version = "*",
        opts = {},
        config = function(_, opts)
            require("toggleterm").setup(opts)
            vim.keymap.set("n", "<leader>q", "<cmd>ToggleTerm<cr>", {})
        end,
    },
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            view_options = {
                show_hidden = true,
            },
        },
        config = function(_, opts)
            require("oil").setup(opts)
            vim.keymap.set("n", "<leader>t", "<CMD>Oil<CR>", { desc = "Open parent directory" })
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "BurntSushi/ripgrep",
            "nvim-telescope/telescope-frecency.nvim",
            "debugloop/telescope-undo.nvim",
        },
        config = function()
            require("telescope").load_extension("frecency")
            require("telescope").load_extension("undo")
            require("telescope").setup({
                defaults = {
                    layout_config = {
                        vertical = { width = 1000 },
                        horizontal = { width = 1000, height = 1000 },
                    },
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
            vim.keymap.set("n", "<Leader>fc", builtin.commands, {})
            vim.keymap.set("n", "<Leader>fr", "<cmd>Telescope frecency<cr>", {})
            vim.keymap.set("n", "<Leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<Leader>fh", builtin.help_tags, {})
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
            vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>")
            vim.keymap.set("n", "<Leader>fi", builtin.lsp_implementations, {})
        end,
    },
    {
        "vimpostor/vim-lumen",
    },
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function(_, opts)
            vim.cmd("colorscheme catppuccin")
            -- vim.api.nvim_create_autocmd({ "CursorMoved" }, {
            --     callback = function()
            --         vim.cmd("highlight StatusLine guibg=NONE")
            --         vim.cmd("highlight StatusLineNC guibg=NONE")
            --         vim.cmd("highlight VertSplit guifg=bg")
            --     end,
            -- })
        end,
    },
}
