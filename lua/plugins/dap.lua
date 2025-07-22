return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
            "theHamsta/nvim-dap-virtual-text",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Setup mason-nvim-dap to auto-install codelldb
            require("mason-nvim-dap").setup({
                ensure_installed = { "codelldb" },
                handlers = {}, -- Automatic DAP configuration
            })

            -- Setup DAP UI
            dapui.setup()

            -- Auto-open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Configure codelldb adapter
            dap.adapters.codelldb = {
                type = "server",
                port = "${port}",
                executable = {
                    command = "codelldb",
                    args = { "--port", "${port}" },
                },
            }

            -- DAP configuration for C
            dap.configurations.c = {
                {
                    name = "Launch with Arguments",
                    type = "codelldb",
                    request = "launch",
                    program = function()
                        -- Assumes binary is in the root folder, built by Makefile
                        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
                    end,
                    args = function()
                        local args_str = vim.fn.input("Arguments: ")
                        return vim.split(args_str, " ")
                    end,
                    cwd = "${workspaceFolder}",
                    stopOnEntry = false,
                    preLaunchTask = "make", -- Run Makefile before debugging
                },
            }

            -- Keymaps for debugging
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
            vim.keymap.set("n", "<leader>ds", dap.step_over, { desc = "Step Over" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
            vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step Out" })
            vim.keymap.set("n", "<leader>dt", dap.terminate, { desc = "Terminate" })

            -- Optional: Inline variable display
            require("nvim-dap-virtual-text").setup()
            require("dap.ext.vscode").load_launchjs()
        end,
    },
}
