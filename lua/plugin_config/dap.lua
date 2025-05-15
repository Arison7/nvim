local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local find_program = function()
  return coroutine.create(function(coro)
    local opts = {}
    pickers
        .new(opts, {
          prompt_title = "Path to executable",
          finder = finders.new_oneshot_job(
            { "fd", "--hidden", "--exclude", ".git", "--no-ignore", "--type", "x" },
            {}
          ),
          sorter = conf.generic_sorter(opts),
          attach_mappings = function(buffer_number)
            actions.select_default:replace(function()
              actions.close(buffer_number)
              coroutine.resume(coro, action_state.get_selected_entry()[1])
            end)
            return true
          end,
        })
        :find()
  end)
end
local find_pid = function()
  return coroutine.create(function(coro)
    local opts = {}
    pickers
        .new(opts, {
          prompt_title = "Select PID",
          finder = finders.new_oneshot_job(
            { "ps", "-e", "-o", "pid,comm" },
            {}
          ),
          sorter = conf.generic_sorter(opts),
          attach_mappings = function(buffer_number)
            actions.select_default:replace(function()
              actions.close(buffer_number)
              local selected_entry = action_state.get_selected_entry()
              local pid = string.match(selected_entry[1], "^%s*(%d+)")
              coroutine.resume(coro, pid)
            end)
            return true
          end,
        })
        :find()
  end)
end



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
            args = {"--port", "${port}"},
      },
}
dap.configurations.rust = {
  {
    name = "Debug",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.getcwd() .. "/target/debug/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
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
vim.keymap.set('n', '<Leader>dc', function() dap.continue() end)
vim.keymap.set('n', '<Leader>do', function() dap.step_over() end)
vim.keymap.set('n', '<Leader>di', function() dap.step_into() end)
vim.keymap.set('n', '<Leader>du', function() dap.step_out() end)
vim.keymap.set('n', '<Leader>db', function() dap.toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>dB', function() dap.set_breakpoint() end)
-- Change thsi later
vim.keymap.set('n', '<Leader>dLB', function()
	dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
end)
vim.keymap.set('n', '<Leader>dr', function() dap.repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() dap.run_last() end)

vim.keymap.set({ 'n', 'v' }, '<Leader>dh', function()
	require('dap.ui.widgets').hover()
end)
vim.keymap.set({ 'n', 'v' }, '<Leader>dp', function()
	require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
	local widgets = require('dap.ui.widgets')
	widgets.centered_float(widgets.scopes)
end)
-- Setup DAP UI and virtual text
require("dapui").setup({})
require("nvim-dap-virtual-text").setup({})

vim.fn.sign_define('DapBreakpoint', { text='●', texthl='Error', linehl='', numhl='' })

