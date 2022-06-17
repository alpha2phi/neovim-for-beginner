local M = {}

local Terminal = require("toggleterm.terminal").Terminal

local git_tui = "lazygit"
-- local git_tui = "gitui"

local git_client = Terminal:new {
  cmd = git_tui,
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

function M.git_client_toggle()
  git_client:toggle()
end

return M
