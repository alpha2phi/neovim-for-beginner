local M = {}

-- Debugger installation location
local HOME = os.getenv "HOME"
local DEBUGGER_LOCATION = HOME .. "/.local/share/nvim/kotlin-debug-adapter"

function M.setup()
  local dap = require "dap"

  -- Adapter configuration
  dap.adapters.kotlin = {
    type = "executable",
    command = DEBUGGER_LOCATION .. "/adapter/build/install/adapter/bin/kotlin-debug-adapter",
    args = { "--interpreter=vscode" },
  }

  -- Configuration
  dap.configurations.kotlin = {
    {
      type = "kotlin",
      name = "launch - kotlin",
      request = "launch",
      projectRoot = vim.fn.getcwd() .. "/app",
      mainClass = function()
        return vim.fn.input("Path to main class > ", "myapp.sample.app.AppKt", "file")
      end,
    },
  }
end

return M
