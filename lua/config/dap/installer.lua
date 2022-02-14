local M = {}

local utils = require "utils"

function M.setup(debuggers)
  local dap_install = require "dap-install"

  dap_install.setup {
    installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  }

  local available_debuggers = require("dap-install.api.debuggers").get_debuggers()
  local installed_debuggers = require("dap-install.api.debuggers").get_installed_debuggers()

  for debugger_name, _ in pairs(debuggers) do
    -- Check if the debugger is supported
    local dbg_supported = available_debuggers[debugger_name]

    if dbg_supported then
      -- Check if the debugger is installed
      local dbg_installed = installed_debuggers[debugger_name]
      if dbg_installed then
        print "Debugger is installed"
      else
        print "Debugger is not installed"
      end

      -- Configure the debugger
      local opts = debuggers[debugger_name]
      -- print(vim.inspect(opts))
      --   dap_install.config(debugger)
    else
      utils.info(debugger_name .. "is not supported", "Debugger")
    end
  end
end

local debuggers = {
  pythoin = { settings = "abc" },
}
M.setup(debuggers)

utils.info("afdfs", " is ready.")
return M
