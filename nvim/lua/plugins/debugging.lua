return {
    {
        "jay-babu/mason-nvim-dap.nvim",
        opts = {
            ensure_installed = { "codelldb" },
        },
    },
    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap" },
        config = function(_, opts)
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup(opts)
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            -- dap.listeners.before.event_terminated["dapui_config"] = function()
            --     dapui.close()
            -- end
            -- dap.listeners.before.event_exited["dapui_config"] = function()
            --     dapui.close()
            -- end
        end,
    },
    {
        "mfussenegger/nvim-dap",
        config = function(_, opts)
            local dap = require("dap")

            local mason_registry = require("mason-registry")
            local codelldb = mason_registry.get_package("codelldb")
            local extension_path = codelldb:get_install_path() .. "/extension/"
            local codelldb_path = extension_path .. "adapter/codelldb"
            local liblldb_path = extension_path .. "lldb/lib/liblldb.so"

            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    -- Change this to your path!
                    command = codelldb_path,
                    args = { "--port", "${port}" },
                },
            }

            dap.configurations.rust = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            dap.configurations.c = {
                {
                    name = "Launch file",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                },
            }

            vim.api.nvim_set_keymap(
                "n",
                "<Leader>b",
                '<Cmd>lua require("dap").toggle_breakpoint()<CR>',
                { noremap = true }
            )
            vim.api.nvim_set_keymap("n", "<Leader>ds", '<Cmd>lua require("dap").step_over()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>dd", '<Cmd>lua require("dap").continue()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>dcc", '<Cmd>lua require("dapui").close()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>dc", '<Cmd>lua require("dap").close()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>dr", '<Cmd>lua require("dap").restart()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>db", '<Cmd>lua require("dap").back()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>di", '<Cmd>lua require("dap").into()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>dov", '<Cmd>lua require("dap").over()<CR>', { noremap = true })
            vim.api.nvim_set_keymap("n", "<Leader>dou", '<Cmd>lua require("dap").out()<CR>', { noremap = true })

            -- RustRunnables
            require("rust-tools").runnables.runnables()
        end,
    },
}
