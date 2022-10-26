local M = {}

local HOME = os.getenv "HOME"
local DEBUGGER_LOCATION = HOME .. "/.local/share/nvim/vscode-chrome-debug"

function M.setup()
  local dap = require "dap"

  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { DEBUGGER_LOCATION .. "/out/src/chromeDebug.js" },
  }

  dap.configurations.javascript = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }

  dap.configurations.javascriptreact = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }

  dap.configurations.typescript = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }

  dap.configurations.typescriptreact = {
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }
end

return M
