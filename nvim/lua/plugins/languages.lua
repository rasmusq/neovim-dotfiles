return {
    { "pest-parser/pest.vim" },
    { "kaarmu/typst.vim", ft = "typst", lazy = false },
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
        config = function(_, opts)
            vim.g.mkdp_auto_close = 0
            vim.g.mkdp_auto_start = 1
            vim.g.mkdp_combine_preview = 1
            vim.g.mkdp_theme = "light"
            vim.g.mkdp_page_title = "${name}"
        end,
    },
    { "ixru/nvim-markdown" },
    { "barreiroleo/ltex_extra.nvim" },
    {
        "simrat39/rust-tools.nvim",
        config = function()
            local mason_registry = require("mason-registry")
            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            local rust_tools = require("rust-tools")
            rust_tools.setup({
                dap = {
                    adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
                },
                server = {
                    capabilities = capabilities,
                    on_attach = function(_, bufnr)
                        local wk = require("which-key")
                        wk.register({
                            L = {
                                name = "Rust-tools",
                                a = { rust_tools.hover_actions.hover_actions, "Hover actions" },
                            },
                        }, { prefix = "<leader>" })
                    end,
                },
                tools = {
                    hover_actions = {
                        border = false, -- see vim.api.nvim_open_win()
                    },
                },
            })
            require("rust-tools").runnables.runnables()
        end,
    },
    {
        "folke/neodev.nvim",
        opts = {
            library = {
                enabled = true, -- when not enabled, neodev will not change any settings to the LSP server
                -- these settings will be used for your Neovim config directory
                runtime = true, -- runtime path
                types = true, -- full signature, docs and completion of vim.api, vim.treesitter, vim.lsp and others
                plugins = true, -- installed opt or start plugins in packpath
                -- you can also specify the list of plugins to make available as a workspace library
                -- plugins = { "nvim-treesitter", "plenary.nvim", "telescope.nvim" },
            },
            setup_jsonls = true, -- configures jsonls to provide completion for project specific .luarc.json files
            -- for your Neovim config directory, the config.library settings will be used as is
            -- for plugin directories (root_dirs having a /lua directory), config.library.plugins will be disabled
            -- for any other directory, config.library.enabled will be set to false
            override = function(root_dir, options) end,
            -- With lspconfig, Neodev will automatically setup your lua-language-server
            -- If you disable this, then you have to set {before_init=require("neodev.lsp").before_init}
            -- in your lsp start options
            lspconfig = true,
            -- much faster, but needs a recent built of lua-language-server
            -- needs lua-language-server >= 3.6.0
            pathStrict = true,
        },
    },
}
