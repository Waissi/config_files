return {
    "mfussenegger/nvim-dap",
    opts = function()
        local dap = require("dap")
        dap.adapters.lua = {
            type = "executable",
            command = "node",
            args = {
                "/Users/yoann/Documents/local-lua-debugger-vscode/extension/debugAdapter.js"
            },
            enrich_config = function(config, on_config)
                if not config["extensionPath"] then
                    local c = vim.deepcopy(config)
                    -- 💀 If this is missing or wrong you'll see
                    -- "module 'lldebugger' not found" errors in the dap-repl when trying to launch a debug session
                    c.extensionPath = "/Users/yoann/Documents/Dev/local-lua-debugger-vscode/"
                    on_config(c)
                else
                    on_config(config)
                end
            end,
        }
        dap.configurations.lua = {
            {
                name = 'Current file (local-lua-dbg, lua)',
                type = 'lua',
                request = 'launch',
                cwd = '${workspaceFolder}',
                program = {
                    command = 'love'
                },
                args = { '${workspaceFolder}', "debug" },
            },
        }
    end,

    keys = {
        { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
        { "<F9>",       function() require("dap").toggle_breakpoint() end,                                    desc = "Toggle Breakpoint" },
        { "<F7>",       function() require("dap").continue() end,                                             desc = "Continue" },
        { "<F5>",       function() require("dap").continue({ before = get_args }) end,                        desc = "Run with Args" },
        { "<leader>dC", function() require("dap").run_to_cursor() end,                                        desc = "Run to Cursor" },
        { "<leader>dg", function() require("dap").goto_() end,                                                desc = "Go to line (no execute)" },
        { "<F8>",       function() require("dap").step_into() end,                                            desc = "Step Into" },
        { "<leader>dj", function() require("dap").down() end,                                                 desc = "Down" },
        { "<leader>dk", function() require("dap").up() end,                                                   desc = "Up" },
        { "<leader>dl", function() require("dap").run_last() end,                                             desc = "Run Last" },
        { "<leader>do", function() require("dap").step_out() end,                                             desc = "Step Out" },
        { "<leader>dO", function() require("dap").step_over() end,                                            desc = "Step Over" },
        { "<leader>dp", function() require("dap").pause() end,                                                desc = "Pause" },
        { "<leader>dr", function() require("dap").repl.toggle() end,                                          desc = "Toggle REPL" },
        { "<leader>ds", function() require("dap").session() end,                                              desc = "Session" },
        { "<F10>",      function() require("dap").terminate() end,                                            desc = "Terminate" },
        { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                     desc = "Widgets" },
    },
}
