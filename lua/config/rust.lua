local M = {}

function M.setup()
  local dbg_path = require("dap-install.config.settings").options["installation_path"] .. "codelldb/"
  local codelldb_path = dbg_path .. "extension/adapter/codelldb"

  require("rust-tools").setup {}
end

return M
