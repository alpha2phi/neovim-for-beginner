local M = {}

function M.find_files()
  local fzf = require "fzf-lua"
  if vim.fn.system "git rev-parse --is-inside-work-tree" == true then
    fzf.files()
  else
    fzf.git_files()
  end
end

M.find_files()

return M
