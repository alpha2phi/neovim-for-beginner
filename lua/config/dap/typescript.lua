-- =============================
--     Typescript Debugging
-- =============================
local M = {}

local debug_utils = require "utils.dap"
local utils = require "utils.core"

-- =============================
--            ADAPTERS
-- =============================
M.adapters = {}

M.adapters.node2 = function(cb, config)
  local cb_input = {
    type = "executable",
    command = os.getenv "HOME" .. "/.nvm/versions/node/v12.18.2/bin/node",
    args = { os.getenv "HOME" .. "/vscode-node-debug2/out/src/nodeDebug.js" },
  }
  if config.request == "attach" and config.mode == "remote" then
    local _, port = debug_utils.start_devenv_debug_session()
    cb_input.enrich_config = function(config, on_config)
      local f_config = vim.deepcopy(config)
      f_config.port = tonumber(port)
      on_config(f_config)
    end
  elseif config.mode == "test" then
    if config.request == "launch" then
      cb_input.enrich_config = function(config, on_config)
        local f_config = vim.deepcopy(config)
        local grepFilter = vim.fn.input "\n[Optional] test filter: "
        if grepFilter ~= "" then
          table.insert(f_config.args, 1, string.format("--grep=%s", grepFilter))
        end
        print(utils.debug_print(f_config))
        on_config(f_config)
      end
    end
  end

  cb(cb_input)
end

M.configurations = {
  {
    type = "node2",
    request = "launch",
    name = "Launch File",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    restart = true,
    protocol = "inspector",
    console = "integratedTerminal",
  },
  {
    type = "node2",
    request = "launch",
    name = "PDaaS Launch",
    program = os.getenv "PLAID_PATH" .. "/pdaas/build/pd2/scripts/cli/index.js",
    runtimeExecutable = os.getenv "HOME" .. "/.nvm/versions/node/v12.18.2/bin/node",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    sourceMapPathOverrides = {
      ["${workspaceFolder}/src/pd2/extractor/**/*.ts"] = "${workspaceFolder}/build/pd2/extractor/**/*.js",
    },
    outFiles = { "${workspaceFolder}/build/**/*.js", "!**/node_modules/**" },
    restart = true,
  },

  -- Works for unit tests that do not need /development-certs/.
  {
    type = "node2",
    request = "launch",
    mode = "test",
    name = "PDaaS Test",
    program = "${workspaceFolder}/node_modules/.bin/mocha",
    console = "integratedTerminal",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    restart = true,
    skipFiles = {
      "<node_internals>/**",
      "**/node_modules/**",
    },
    runtimeExecutable = os.getenv "HOME" .. "/.nvm/versions/node/v12.18.2/bin/node",
    args = {
      "--exit",
      "--require=source-map-support/register",
      "--require=${workspaceFolder}/build/test/init",
      "--file=${workspaceFolder}/build/test/global-hooks",
      "--timeout=999999",
      "--colors",
    },
    envFile = "${workspaceFolder}/environment/development",
    env = {
      ["NODE_EXTRA_CA_CERTS"] = "${workspaceFolder}/resources/pd2/cert/extended-intermediate-certificates.pem",
    },
    protocol = "inspector",
    outFiles = { "${workspaceFolder}/build/**/*.js", "!**/node_modules/**" },
  },
  {
    type = "node2",
    request = "attach",
    mode = "remote",
    name = "Remote Attach",
    cwd = vim.fn.getcwd(),
    localRoot = vim.fn.getcwd(),
    remoteRoot = "/usr/src/app",
    sourceMaps = true,
    skipFiles = {
      "**/node_modules/**",
      "<node_internals>/**",
    },
    protocol = "inspector",
    console = "integratedTerminal",
    outFiles = { "${workspaceFolder}/build/**/*.js", "!**/node_modules/**" },
    restart = true,
  },
}

return M
