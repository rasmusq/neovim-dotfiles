return {
    -- {
    --     "zbirenbaum/copilot.lua",
    --     opts = {
    --         panel = {
    --             enabled = true,
    --             auto_refresh = false,
    --             keymap = {
    --                 jump_prev = "[[",
    --                 jump_next = "]]",
    --                 accept = "<CR>",
    --                 refresh = "gr",
    --                 open = "<M-CR>",
    --             },
    --             layout = {
    --                 position = "bottom", -- | top | left | right
    --                 ratio = 0.4,
    --             },
    --         },
    --         suggestion = {
    --             enabled = true,
    --             auto_trigger = true,
    --             debounce = 75,
    --             keymap = {
    --                 accept = "<C-l>",
    --                 accept_word = false,
    --                 accept_line = false,
    --                 next = "<C-]>",
    --                 prev = "<C-[>",
    --                 dismiss = "<C-u>",
    --             },
    --         },
    --         filetypes = {
    --             yaml = false,
    --             markdown = true,
    --             help = false,
    --             gitcommit = false,
    --             gitrebase = false,
    --             hgcommit = false,
    --             svn = false,
    --             cvs = false,
    --             ["."] = false,
    --         },
    --         copilot_node_command = "node", -- Node.js version must be > 18.x
    --         server_opts_overrides = {},
    --     },
    --     config = function(_, opts)
    --         require("copilot").setup(opts)
    --         local wk = require("which-key")
    --         wk.register({
    --             c = {
    --                 name = "Copilot",
    --                 l = { require("copilot.suggestion").accept_line(), "Accept line" },
    --             },
    --         }, { prefix = "<leader>" })
    --     end,
    -- },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-nvim-lsp-document-symbol",
            "saadparwaiz1/cmp_luasnip",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-cmdline",
        },
        opts = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            vim.opt.completeopt = { "menu", "menuone", "noselect" }
            return {
                -- Snippet engine settings
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- Keymap
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
                    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
                    -- ["<C-Space>"] = cmp.mapping.complete(),
                    ["<esc>"] = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                -- Sources
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" }, -- For luasnip users.
                    {
                        name = "spell",
                        option = {
                            keep_all_entries = false,
                            enable_in_context = function()
                                return true
                            end,
                        },
                    },
                    { name = "path" },
                    { name = "nvim_lsp_signature_help" },
                    { name = "buffer" },
                }),
                window = {
                    completion = {
                        scrollbar = false,
                    },
                },
            }
        end,
        config = function(_, opts)
            local cmp = require("cmp")
            cmp.setup(opts)
        end,
    },
    {
        "L3MON4D3/LuaSnip",
        opts = {},
        config = function(plugin, opts)
            local luasnip = require("luasnip")
            local snip = luasnip.snippet
            local node = luasnip.snippet_node
            local text = luasnip.text_node
            local insert = luasnip.insert_node
            local func = luasnip.function_node
            local choice = luasnip.choice_node
            local dynamicn = luasnip.dynamic_node
            local fmt = require("luasnip.extras.fmt").fmt

            luasnip.add_snippets(nil, {
                typst = {
                    snip(
                        {
                            trig = "figure",
                            namr = "Figure",
                            dscr = "Make a figure template",
                        },
                        fmt(
                            [[
#figure(
    {contents},
    caption: [{caption}],
) <{reference}>
	    ]],
                            {
                                contents = insert(1, "contents"),
                                caption = insert(2, "caption"),
                                reference = insert(3, "reference"),
                            }
                        )
                    ),
                    snip(
                        {
                            trig = "code",
                            namr = "Code",
                            dscr = "Make a code template",
                        },
                        fmt(
                            [[
```{language}
{contents}
```
	    ]],
                            {
                                language = insert(1, "language"),
                                contents = insert(2, "contents"),
                            }
                        )
                    ),
                    snip(
                        {
                            trig = "gls",
                            namr = "Glossary",
                            dscr = "Make a glossary template",
                        },
                        fmt(
                            [[
#gls[{term}]
]],
                            {
                                term = insert(1, "term"),
                            }
                        )
                    ),
                },
            })
            vim.keymap.set({ "i", "s" }, "<C-n>", function()
                luasnip.jump(1)
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-e>", function()
                luasnip.jump(-1)
            end, { silent = true })
        end,
    },
}
