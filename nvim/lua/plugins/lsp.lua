return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("UserLspConfig", {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    local wk = require("which-key")
                    wk.register({
                        l = {
                            name = "LSP",
                            d = { vim.lsp.buf.declaration, "Declaration" },
                            i = { vim.lsp.buf.implementation, "Implementation" },
                            D = { vim.lsp.buf.definition, "Definition" },
                            r = { vim.lsp.buf.references, "References" },
                            R = { vim.lsp.buf.rename, "Rename" },
                            h = { vim.lsp.buf.hover, "Hover" },
                            H = { vim.lsp.buf.signature_help, "Help" },
                            f = {
                                name = "workspace folders",
                                a = { vim.lsp.buf.add_workspace_folder, "Add workspace folder" },
                                r = { vim.lsp.buf.remove_workspace_folder, "Remove workspace folder" },
                                l = {
                                    function()
                                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                                    end,
                                    "List workspace folders",
                                },
                            },
                            t = { vim.lsp.buf.type_definition, "Type definition" },
                            a = { vim.lsp.buf.code_action, "Code actions" },
                        },
                    }, { prefix = "<leader>" })
                end,
            })

            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()
            -- Commented out because there is a new kid on the block; tinymist
            -- lspconfig.typst_lsp.setup({
            --     capabilities = capabilities,
            --     settings = {
            --         exportpdf = "onsave", -- ontype/onsave/never.
            --     },
            -- })
            lspconfig.tinymist.setup({
                capabilities = capabilities,
                settings = {
                    exportPdf = "onType",
                    -- on_attach = function()
                    --     vim.lsp.buf.execute_command({
                    --         command = "tinymist.pinMain",
                    --         arguments = { vim.api.nvim_buf_get_name(0) },
                    --     })
                    -- end,
                },
            })
            -- Commented out because rustaceanvim sets it up on its own
            -- lspconfig.rust_analyzer.setup({ capabilities = capabilities })
            lspconfig.pest_ls.setup({ capabilities = capabilities })
            lspconfig.grammarly.setup({
                capabilities = capabilities,
                filetypes = { "markdown", "latex", "typst" },
            })
            lspconfig.remark_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.html.setup({
                capabilities = capabilities,
            })
            lspconfig.tsserver.setup({
                capabilities = capabilities,
            })
            lspconfig.svelte.setup({
                capabilities = capabilities,
            })
            lspconfig.cssls.setup({
                capabilities = capabilities,
            })
            lspconfig.csharp_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.cmake.setup({
                capabilities = capabilities,
            })
            lspconfig.clangd.setup({
                capabilities = capabilities,
            })
            lspconfig.kotlin_language_server.setup({
                capabilities = capabilities,
            })
            lspconfig.golangci_lint_ls.setup({
                capabilities = capabilities,
            })
            lspconfig.ltex.setup({
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    require("ltex_extra").setup({
                        load_langs = { "en-US" },
                        path = ".vscode",
                        -- path = vim.fn.expand('~') .. '/.local/share/ltex',
                    })
                end,
                settings = {
                    ltex = {
                        completionEnabled = true,
                        language = "en-US",
                    },
                },
                filetypes = {
                    "bib",
                    "gitcommit",
                    "markdown",
                    "org",
                    "plaintex",
                    "rst",
                    "rnoweb",
                    "tex",
                    "pandoc",
                    "quarto",
                    "rmd",
                },
            })

            lspconfig.lua_ls.setup({
                capabilities = capabilities,
                settings = {
                    Lua = {
                        diagnostics = {
                            unusedLocalExclude = {
                                "opts",
                            },
                            globals = {
                                "vim",
                                "describe",
                                "it",
                                "before_each",
                                "after_each",
                                "pending",
                            },
                        },
                    },
                },
                on_init = function(client)
                    local path = client.workspace_folders[1].name
                    if
                        not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc")
                    then
                        client.config.settings = vim.tbl_deep_extend("force", client.config.settings, {
                            Lua = {
                                runtime = {
                                    version = "LuaJIT",
                                },
                                -- Make the server aware of Neovim runtime files
                                workspace = {
                                    checkThirdParty = false,
                                    library = {
                                        vim.env.VIMRUNTIME,
                                    },
                                },
                            },
                        })
                        client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
                    end
                    return true
                end,
            })
        end,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "golangci_lint_ls",
                "clangd",
                "cmake",
                "csharp_ls",
                "cssls",
                "grammarly",
                "html",
                "jdtls",
                "ltex",
                "lua_ls",
                "marksman",
                "pyright",
                "rust_analyzer",
                "pest_ls",
                "tsserver",
                "typst_lsp",
            },
        },
        config = function(_, opts)
            local mason_lspconfig = require("mason-lspconfig")
            mason_lspconfig.setup(opts)

            mason_lspconfig.setup_handlers({

                ["pest_ls"] = function()
                    require("pest-vim").setup({})
                end,
            })
        end,
    },
    {
        "williamboman/mason.nvim",
        opts = {
            ui = {
                -- border = "rounded",
                show_header = false,
                icons = {
                    -- package_installed = "✓",
                    -- package_pending = "➜",
                    -- package_uninstalled = "✗",
                    -- package_installed = "󰱒",
                    -- package_pending = "󰡖",
                    -- package_uninstalled = "󰄱",
                    package_installed = "●",
                    package_pending = "●",
                    package_uninstalled = "○",
                },
            },
        },
        config = function(_, opts)
            require("mason").setup(opts)
        end,
    },
}
