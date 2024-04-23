local change_highlight = function()
    vim.cmd("highlight VertSplit guifg=bg")
    vim.cmd("highlight NormalFloat guibg=NONE ctermbg=NONE")
    vim.cmd("highlight FloatBorder guibg=NONE ctermbg=NONE")
    vim.cmd("highlight StatusLine guibg=NONE ctermbg=NONE")
    vim.cmd("highlight StatusLineNC guibg=NONE")
    vim.cmd("highlight MsgArea guibg=NONE ctermbg=NONE")
end

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
        config = function(_, opts)
            require("diffview").setup(opts)
            local wk = require("which-key")
            wk.register({
                D = {
                    name = "Diffview",
                    o = { "<cmd>DiffviewOpen<cr>", "Open" },
                    O = { "<cmd>DiffviewOpen", "Open custom commits" },
                    c = { "<cmd>DiffviewClose<cr>", "Close" },
                    t = { "<cmd>DiffviewToggleFiles<cr>", "Goto next" },
                    q = { "<cmd>DiffviewOpen<cr>", "Set loclist" },
                },
            }, { prefix = "<leader>" })
        end,
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
        opts = {
            popup_border_style = "solid",
        },
        config = function(_, opts)
            require("neo-tree").setup(opts)
            vim.keymap.set("n", "<leader>t", "<cmd>Neotree<cr>", {})
        end,
    },
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {
            "telescope",
            fzf_opts = { ["--layout"] = "default", ["--marker"] = "+" },
            winopts = {
                border = { "", "", "", "", "", "", "", "" },
                preview = {
                    scrollbar = "none",
                    scrollchars = { "", "" },
                    border = "none",
                    title = false,
                    layout = "flex",
                    hidden = "nohidden",
                    winopts = {},
                    vertical = "up:80%",
                    horizontal = "right:80%",
                },
            },
            hls = {
                normal = "TelescopeNormal",
                border = "TelescopeBorder",
                title = "TelescopeTitle",
                help_normal = "TelescopeNormal",
                help_border = "TelescopeBorder",
                preview_normal = "TelescopeNormal",
                preview_border = "TelescopeNormal",
                preview_title = "TelescopeTitle",
                -- builtin preview only
                cursor = "TelescopeNormal",
                cursorline = "TelescopeNormal",
                cursorlinenr = "TelescopePreviewLine",
                search = "TelescopeNormal",
            },
        },
        config = function(_, opts)
            require("fzf-lua").setup(opts)

            local wk = require("which-key")
            wk.register({
                f = {
                    name = "Telescope",
                    f = { require("fzf-lua").files, "Files" },
                    g = { require("fzf-lua").live_grep, "Live Grep" },
                    G = { require("fzf-lua").grep, "Grep" },
                    t = {
                        "<cmd>lua require('fzf-lua').grep({search='TODO|HACK|PERF|NOTE|FIX', no_esc=true})<cr>",
                        "Todos",
                    },

                    s = { require("fzf-lua").lsp_document_symbols, "Document symbols" },
                    S = { require("fzf-lua").lsp_workspace_symbols, "Workspace symbols" },
                    i = { require("fzf-lua").lsp_implementations, "Implementations" },
                    r = { require("fzf-lua").lsp_references, "References" },
                    e = { require("fzf-lua").lsp_definitions, "Definitions" },
                    E = { require("fzf-lua").lsp_declarations, "Declarations" },
                    y = { require("fzf-lua").lsp_typedefs, "Type definitions" },
                    a = { require("fzf-lua").lsp_code_actions, "Code actions" },
                    T = { require("fzf-lua").treesitter, "Treesitter" },

                    D = { require("fzf-lua").diagnostics_workspace, "Workspace diagnostics" },
                    d = { require("fzf-lua").diagnostics_document, "Document diagnostics" },
                    b = { require("fzf-lua").buffers, "Buffers" },
                    m = { require("fzf-lua").marks, "Marks" },
                    h = { require("fzf-lua").help_tags, "Help" },
                    C = { require("fzf-lua").commands, "Commands" },
                    o = { require("fzf-lua").colorschemes, "Colorschemes" },

                    I = { require("fzf-lua").git_status, "Git status" },
                    B = { require("fzf-lua").git_branches, "Git branches" },
                    c = { require("fzf-lua").git_commits, "Git commits" },
                },
            }, { prefix = "<leader>" })
        end,
    },
    {
        "folke/todo-comments.nvim",
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
    },
    {
        "kepano/flexoki-neovim",
        name = "flexoki",
        opts = {},
    },
    { "rose-pine/neovim", name = "rose-pine" },
    {
        "f-person/auto-dark-mode.nvim",
        opts = {
            update_interval = 100,
            set_dark_mode = function()
                vim.api.nvim_set_option("background", "dark")
                vim.cmd("colorscheme default")
                if not vim.g.neovide then
                    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
                end
                change_highlight()
            end,
            set_light_mode = function()
                vim.api.nvim_set_option("background", "light")
                vim.cmd("colorscheme default")
                if not vim.g.neovide then
                    vim.cmd("highlight Normal guibg=NONE ctermbg=NONE")
                end
                change_highlight()
            end,
        },
        config = function(_, opts)
            require("auto-dark-mode").setup(opts)
        end,
    },
}
