local M = {}

function M.setup()
  require("mini.ai").setup {}
  require("mini.align").setup {}
  require("mini.jump").setup {}
end

return M
