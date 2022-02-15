local M = {}

local utils = require "utils"

--- List of debuggers. true indicates we want to use the installer
local debuggers = {
  python = true,
  lua = false,
}

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
  for debugger_name, _ in pairs(debuggers) do
    local use_installer = debuggers[debugger_name]
    if use_installer then
      local is_installed = utils.exists(installed_debuggers, debugger_name)
      if is_installed then
        local avail_config, dap_config = pcall(require, "config.dap." .. debugger_name)
        if avail_config then
          dap_config.setup(dap_install)
        else
          dap_install.config()
        end
      else
        utils.info(debugger_name .. " is not installed", "DAP")
      end
    else
      local avail_config, dap_config = pcall(require, "config.dap." .. debugger_name)
      if avail_config then
        dap_config.setup()
      else
        utils.info("Custom debugger [" .. debugger_name .. "] is not configured", "DAP")
      end
    end
  end
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
