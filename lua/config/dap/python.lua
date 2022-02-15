local M = {}

function M.setup(dap_install)
  -- use nvim-dap-python
  print "Setting python debugger"
  require("dap-python").setup()
end

return M
