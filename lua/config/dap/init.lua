local M = {}

local function configure()
  local dap_install = require "dap-install"
  dap_install.setup {
    installation_path = vim.fn.stdpath "data" .. "/dapinstall/",
  }

  local dap_breakpoint = {
    error = {
      text = "🟥",
      texthl = "LspDiagnosticsSignError",
      linehl = "",
      numhl = "",
    },
    rejected = {
      text = "",
      texthl = "LspDiagnosticsSignHint",
      linehl = "",
      numhl = "",
    },
    stopped = {
      text = "⭐️",
      texthl = "LspDiagnosticsSignInformation",
      linehl = "DiagnosticUnderlineInfo",
      numhl = "LspDiagnosticsSignInformation",
    },
  }

  vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
  vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)
  vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
end

local function configure_exts()
  require("nvim-dap-virtual-text").setup()
  require("dapui").setup()
end

local function configure_debuggers()
  require("config.dap.python").setup()
  require("config.dap.lua").setup()

  -- local installed_debuggers = require("dap-install.api.debuggers").get_installed_debuggers()
  -- for debugger_name, _ in pairs(debuggers) do
  --   local use_installer = debuggers[debugger_name]
  --   if use_installer then
  --     local is_installed = utils.exists(installed_debuggers, debugger_name)
  --     if is_installed then
  --       local avail_config, dap_config = pcall(require, "config.dap." .. debugger_name)
  --       if avail_config then
  --         dap_config.setup(dap_install)
  --       else
  --         dap_install.config(debugger_name, {}) -- Use default configuration
  --       end
  --     else
  --       utils.info("Debugger [" .. debugger_name .. "] is not installed", "DAP")
  --     end
  --   else
  --     local avail_config, dap_config = pcall(require, "config.dap." .. debugger_name)
  --     if avail_config then
  --       dap_config.setup()
  --     else
  --       utils.info("Custom debugger [" .. debugger_name .. "] is not configured", "DAP")
  --     end
  --   end
  -- end
end

function M.setup()
  configure() -- Configuration
  configure_exts() -- Extensions
  configure_debuggers() -- Debugger
  require("config.dap.keymaps").setup() -- Keymaps
end

configure_debuggers()

return M
