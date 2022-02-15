local M = {}

function M.setup(dap_install)
  -- use nvim-dap-python
  require("dap-python").setup()
end

return M
