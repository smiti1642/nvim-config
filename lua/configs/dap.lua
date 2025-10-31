local dap = require('dap')
local dapui = require('dapui')

-- Setup for mason-nvim-dap
-- This will ensure the adapters are installed and automatically configured
require('mason-nvim-dap').setup({
  ensure_installed = { 'codelldb', 'debugpy' },
  handlers = {},
})

-- Basic setup for dapui
dapui.setup()

-- Open/close dapui on debug events
dap.listeners.after.event_initialized['dapui_config'] = function()
  dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
  dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
  dapui.close()
end
