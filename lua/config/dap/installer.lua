local M = {}

function M.setup(debuggers)
  local dap_install = require "dap-install"

  dap_install.setup {
    installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  }

  local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
  for _, debugger in ipairs(dbg_list) do
    dap_install.config(debugger)
  end
end

return M
