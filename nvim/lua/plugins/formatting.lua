return {
    {
        "stevearc/conform.nvim",
        opts = {
            formatters_by_ft = {
                lua = { "stylua" },
                bib = { "bibtex-tidy" },
                rust = { "rustfmt" },
                xml = { "xmlformat" },
                go = { "goimports" },
                markdown = { "prettier" },
                cpp = { "clang_format" },
                javascript = { "prettier" },
            },
        },
        config = function(_, opts)
            require("conform").setup(opts)
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    require("conform").format({ bufnr = args.buf })
                end,
            })
        end,
    },
}
