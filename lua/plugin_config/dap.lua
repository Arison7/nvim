-- nvim-dap Configuration
local dap, dapui = require('dap'), require('dapui')

dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
end

dap.adapters.codelldb = {
    type = "server",
    port = "${port}",
    executable = {
        command = "codelldb",
        args = { "--port", "${port}" },
    },
}


dap.adapters.gdb = {
    type = 'executable',
    command = 'gdb',
    args = { '--quiet', '--interpreter=dap' },
}


dap.configurations.rust = {
    {
        name = "Debug GDB",
        type = "gdb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = false,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
    },
    {
        name = "Attach to process (GDB)",
        type = "gdb",
        request = "attach",
        processId = require('dap.utils').pick_process,
    },
    {
        name = "Debug codellb",
        type = "codelldb",
        request = "launch",
        program = function()
            return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
        args = function()
            local args_string = vim.fn.input("Arguments: ")
            return vim.split(args_string, " ")
        end,
    },
}
--[[
--
--
dap.configurations.rust = {
      {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = find_program,
            args = {},
            cwd = '${workspaceFolder}',
      },
      {
            name = "Atach to process",
            type = "codelldb",
            request = "attach",
            program = find_program,
            pid = find_pid,
            cwd = '${workspaceFolder}'
      },
      {
            name = 'Attach to server :1234',
            type = 'codelldb',
            request = 'attach',
            connect = {
                  port = 1234,
                  host = 'localhost',
            },
            program = find_program,
            cwd = '${workspaceFolder}'
      },
    }
--]]
--
--Key binds
vim.keymap.set('n', '<Leader>dc', function() dap.continue() end, { desc = "Start/Continue Execution" })
vim.keymap.set('n', '<Leader>do', function() dap.step_over() end, { desc = "Step Over Line" })
vim.keymap.set('n', '<Leader>di', function() dap.step_into() end, { desc = "Step Into Function" })
vim.keymap.set('n', '<Leader>du', function() dap.step_out() end, { desc = "Step Out of Function" })
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end, { desc = "Set Conditional Breakpoint" })
vim.keymap.set('n', '<Leader>dLB', function()
    dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end, { desc = "Set Log Point" })
vim.keymap.set('n', '<Leader>dr', function() dap.repl.toggle() end, { desc = "Open Interactive Console" })
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end, { desc = "Run Last Config" })
vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
    require('dap.ui.widgets').hover()
end, { desc = "Show Variable Info" })
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
    require('dap.ui.widgets').preview()
end, { desc = "Preview Value" })
vim.keymap.set('n', '<Leader>df', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.frames)
end, { desc = "Show Call Stack" })
vim.keymap.set('n', '<Leader>ds', function()
    local widgets = require('dap.ui.widgets')
    widgets.centered_float(widgets.scopes)
end, { desc = "Show Variable Scopes" })

vim.keymap.set('n', '<Leader>dt', function()
    dap.terminate()
    dapui.close()
end, { desc = "Terminate" })

-- Setup DAP UI and virtual text
require("dapui").setup({})
require("nvim-dap-virtual-text").setup({})

vim.fn.sign_define('DapBreakpoint', { text = '●', texthl = 'Error', linehl = '', numhl = '' })
