local M = {}

local function configure_exts()
  -- DAP virtual text
  require("nvim-dap-virtual-text").setup()

  -- DAP UI
  require("dapui").setup()
end

local function configure_debuggers()
  local dap_install = require "dap-install"

  dap_install.setup {
    installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  }

  local installed_debuggers = require("dap-install.api.debuggers").get_installed_debuggers()
  for _, debugger_name in pairs(installed_debuggers) do
    local avail_config, dap_config = pcall(require, "config.dap." .. debugger_name)
    if avail_config then
      print("Configure " .. debugger_name)
      dap_config.setup(dap_install)
    end
  end

  -- local available_debuggers = require("dap-install.api.debuggers").get_debuggers()
  -- for debugger_name, _ in pairs(debuggers) do
  --   -- Check if the debugger is supported
  --   local dbg_supported = available_debuggers[debugger_name]
  --
  --   if dbg_supported then
  --     -- Check if the debugger is installed
  --     local dbg_installed = installed_debuggers[debugger_name]
  --     if dbg_installed == nil then
  --       -- utils.info("Installing " .. debugger_name, "Debugger")
  --       -- require("dap-install.main").main(0, debugger_name)
  --     end
  --
  --     -- Configure the debugger
  --     local opts = debuggers[debugger_name]
  --     -- print(vim.inspect(opts))
  --     --   dap_install.config(debugger)
  --   else
  --     utils.info(debugger_name .. "is not supported", "Debugger")
  --   end
  -- end
end

function M.setup()
  -- Configure extensions
  configure_exts()

  -- Configure debuggers
  configure_debuggers()

  -- Configure keymaps
  require("config.dap.keymaps").setup()
end

configure_debuggers()

return M
