require "nvchad.mappings"

local map = vim.keymap.set

-- custom mappings here
-- 第一行代表設定 normal 模式下輸入 <leader>ld 開啟 WorkSpace 的 Diagnostics 懸浮視窗
map("n", "<leader>ld", "<cmd>Telescope diagnostics <CR>", { desc = "Workspace diagnostics" })
map("n", "<leader>lb", "<cmd>Telescope lsp_document_symbols <CR>", { desc = "Buffer symbols" })
map("n", "<leader>lw", "<cmd>Telescope lsp_dynamic_workspace_symbols <CR>", { desc = "WorkSpace symbols" })

-- Copilot use Ctrl+q to accept
map('i', '<C-q>', function ()
  vim.fn.feedkeys(vim.fn['copilot#Accept'](), '')
end, { desc = 'Copilot Accept', noremap = true, silent = true })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

map("n", "<leader>s", "<cmd>CopilotChat<CR>", { desc = "Open CopilotChat" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

-- DAP (Debug Adapter Protocol) Mappings - Visual Studio Style
local dap = require('dap')
map('n', '<F5>', function() dap.continue() end, { desc = "DAP: Start/Continue" })
map('n', '<S-F5>', function() dap.terminate() end, { desc = "DAP: Terminate Session" })
map('n', '<F9>', function() dap.toggle_breakpoint() end, { desc = "DAP: Toggle Breakpoint" })
map('n', '<F10>', function() dap.step_over() end, { desc = "DAP: Step Over" })
map('n', '<F11>', function() dap.step_into() end, { desc = "DAP: Step Into" })
map('n', '<S-F11>', function() dap.step_out() end, { desc = "DAP: Step Out" })
map('n', '<leader>du', function() require('dapui').toggle() end, { desc = "DAP: Toggle UI" })

-- Flash (enhanced navigation)
-- Use 's' to trigger flash jump in normal, visual and operator-pending modes
map({ "n", "x", "o" }, "s", function() require("flash").jump() end, { desc = "Flash Jump" })
map({ "n", "o", "x" }, "<leader>fs", function() require("flash").treesitter_search() end, { desc = "Flash Treesitter Search" })
