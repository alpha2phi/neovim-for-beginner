local M = {}

function M.setup()
  local cybu = require "cybu"
  cybu.setup()
  -- vim.keymap.set("n", "K", "<Plug>(CybuPrev)")
  -- vim.keymap.set("n", "J", "<Plug>(CybuNext)")
  -- vim.keymap.set({"n", "v"}, "<c-s-tab>", "<plug>(CybuLastusedPrev)")
  vim.keymap.set({ "n", "v" }, "<C-Tab>", "<Plug>(CybuLastusedNext)")
end

return M
