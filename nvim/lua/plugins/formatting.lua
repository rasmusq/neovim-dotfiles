return {
    {
        "mhartington/formatter.nvim",
        opts = function()
            local util = require("formatter.util")
            return {
                logging = true,
                log_level = vim.log.levels.WARN,
                -- All formatter configurations are opt-in
                filetype = {
                    lua = {
                        require("formatter.filetypes.lua").stylua,
                        function()
                            return {
                                exe = "stylua",
                                args = {
                                    "--search-parent-directories",
                                    "--stdin-filepath",
                                    util.escape_path(util.get_current_buffer_file_path()),
                                    "--",
                                    "-",
                                },
                                stdin = true,
                            }
                        end,
                    },
                    markdown = {
                        require("formatter.filetypes.markdown").prettier,
                    },
                    rust = {
                        require("formatter.filetypes.rust").rustfmt,
                    },
                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace,
                    },
                },
            }
        end,
        config = function(_, opts)
            require("formatter").setup(opts)
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    vim.cmd("FormatWrite")
                end,
            })
        end,
    },
}
