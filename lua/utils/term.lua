local M = {}

local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new {
  cmd = "lazygit",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

function M.lazygit_toggle()
  lazygit:toggle()
end

return M
