local M = {}

function M.setup()
  local cybu = require "cybu"
  cybu.setup()
  vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
  vim.keymap.set("n", "J", "<Plug>(CybuNext)")
end

return M
