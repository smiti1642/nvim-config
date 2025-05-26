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

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
