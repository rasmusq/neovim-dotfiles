return {
    {
        "mfussenegger/nvim-lint",
        config = function(_, opts)
            require("lint").linters_by_ft = {
                c = { "cpplint" },
                cmake = { "cmakelint" },
                cpp = { "cpplint" },
                markdown = { "markdownlint" },
                lua = { "luacheck" },
                css = { "stylelint" },
                scss = { "stylelint" },
                sass = { "stylelint" },
                html = { "markuplint" },
                java = { "checkstyle" },
                javascript = { "eslint_d" },
                typescript = { "eslint_d" },
                python = { "flake8" },
            }

            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
}
