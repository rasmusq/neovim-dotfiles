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
            "folke/todo-comments.nvim",
        },
        config = function()
            require("todo-comments").setup({
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
            })

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
            local wk = require("which-key")
            wk.register({
                f = {
                    name = "find",
                    f = { builtin.find_files, "files" },
                    C = { builtin.commands, "commands" },
                    h = { "<cmd>Telescope file_history history<cr>", "history" },
                    r = { "<cmd>Telescope frecency<cr>", "frecency" },
                    g = { builtin.live_grep, "live grep" },
                    H = { builtin.help_tags, "help" },
                    s = { builtin.lsp_document_symbols, "document symbols" },
                    S = { builtin.lsp_dynamic_workspace_symbols, "dynamic workspace symbols" },
                    T = { builtin.treesitter, "treesitter" },
                    t = { "<cmd>TodoTelescope<cr>", "todos" },
                    D = { builtin.diagnostics, "project diagnostics" },
                    d = {
                        function()
                            builtin.diagnostics({ bufnr = 0 })
                        end,
                        "file diagnostict",
                    },
                    b = { builtin.buffers, "buffers" },
                    l = { builtin.git_status, "git status" },
                    m = { builtin.marks, "marks" },
                    a = { builtin.git_branches, "git branches" },
                    c = { builtin.git_commits, "git commits" },
                    u = { "<cmd>Telescope undo<cr>", "undo history" },
                    i = { builtin.lsp_implementations, "implementations" },
                },
            }, { prefix = "<leader>" })
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
