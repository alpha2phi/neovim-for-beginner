local M = {}

function M.setup(_)
  require("dap-python").setup "~/miniconda3/bin/python"
end

return M
