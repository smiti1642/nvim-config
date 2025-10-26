-- Load NvChad's LSP defaults
require("nvchad.configs.lspconfig").defaults()

-- NvChad helpers
local nvlsp = require("nvchad.configs.lspconfig")

-- List of servers
local servers = { "html", "cssls", "rust_analyzer", "clangd", "pyright" }

-- Define Python with strict mode
vim.lsp.config("pyright", {
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",
        autoImportCompletions = true,
      },
    },
  },
})

-- Apply defaults for other servers
for _, lsp in ipairs(servers) do
  if lsp ~= "pyright" then
    vim.lsp.config(lsp, {
      on_attach = nvlsp.on_attach,
      on_init = nvlsp.on_init,
      capabilities = nvlsp.capabilities,
    })
  end
end

-- Optional example: TypeScript
-- vim.lsp.config("ts_ls", {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- })

