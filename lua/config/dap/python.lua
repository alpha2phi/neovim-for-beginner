local M = {}

function M.setup(_)
  require("dap-python").setup("python", {})
  table.insert(require("dap").configurations.python, {
    type = "python",
    request = "attach",
    connect = {
      port = 5678,
      host = "127.0.0.1",
    },
    mode = "remote",
    name = "Container Attach Debug",
    cwd = vim.fn.getcwd(),
    pathMappings = {
      {
        localRoot = "/home/alpha2phi/workspace/alpha2phi/python-apps/ml-yolo/backend", -- Local folder the code lives
        remoteRoot = "/fastapi", -- Wherever your Python code lives in the container.
      },
    },
  })
end

return M
