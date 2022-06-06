local M = {}

-- Debugger installation location
local HOME = os.getenv "HOME"
local DEBUGGER_LOCATION = HOME .. "/.local/share/nvim/kotlin-debug-adapter"

function M.setup()
  local dap = require "dap"

  -- Adapter configuration
  dap.adapters.kotlin = {}

  -- Configuration
  dap.configurations.kotlin = {
    {},
  }
end

return M
