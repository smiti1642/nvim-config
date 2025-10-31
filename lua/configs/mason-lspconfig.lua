local servers = require "configs.lsp_servers"

return {
  automatic_installation = true,
  ensure_installed = servers,
}
