-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

return {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "williamboman/mason.nvim",
        "jay-babu/mason-nvim-dap.nvim",
        "leoluz/nvim-dap-go",
        "nvim-neotest/nvim-nio",
    },
    config = function()
        local dap = require("dap")
        local dapui = require("dapui")
        dap.listeners.before.attach.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.launch.dapui_config = function()
            dapui.open()
        end
        dap.listeners.before.event_terminated.dapui_config = function()
            dapui.close()
        end
        dap.listeners.before.event_exited.dapui_config = function()
            dapui.close()
        end

        require("mason-nvim-dap").setup({
            automatic_setup = true,
            handlers = {},
            ensure_installed = {
                "codelldb",
            },
        })

        local wk = require("which-key")
        wk.register({
            e = {
                name = "Debugging",
                c = { dap.continue, "Continue" },
                Q = { dap.terminate, "Terminate" },
                i = { dap.step_into, "Step into" },
                o = { dap.step_over, "Step over" },
                O = { dap.step_out, "Step out" },
                b = { dap.toggle_breakpoint, "Toggle breakpoint" },
                B = {
                    function()
                        dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
                    end,
                    "Create conditional breakpoint",
                },
                u = { dapui.toggle, "Toggle UI" },
            },
        }, { prefix = "<leader>" })

        dapui.setup({})

        -- Install golang specific config
        require("dap-go").setup()

        local mason_registry = require("mason-registry")
        local codelldb = mason_registry.get_package("codelldb")
        local extension_path = codelldb:get_install_path() .. "/extension/"
        local codelldb_path = extension_path .. "adapter/codelldb"

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
    end,
}
