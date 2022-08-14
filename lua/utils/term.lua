local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- Git client
local git_tui = "lazygit"
-- local git_tui = "gitui"

-- Committizen
local git_cz = "git cz"

local git_client = Terminal:new {
  cmd = git_tui,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

local git_commit = Terminal:new {
  cmd = git_cz,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

function M.git_client_toggle()
  git_client:toggle()
end

function M.git_commit_toggle()
  git_commit:toggle()
end

return M
