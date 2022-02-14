local M = {}

local whichkey = require "which-key"

local function keymap(lhs, rhs)
  vim.keymap.set("n", lhs, rhs, { silent = true })
end

function M.setup()
  print "Setting up DAP key mappings"
end

return M
