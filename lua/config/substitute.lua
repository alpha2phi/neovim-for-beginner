local M = {}

function M.setup()
  require("substitute").setup()
  vim.keymap.set("n", "t", "<cmd>lua require('substitute').operator()<cr>", { noremap = true })
  vim.keymap.set("n", "tt", "<cmd>lua require('substitute').line()<cr>", { noremap = true })
  vim.keymap.set("n", "T", "<cmd>lua require('substitute').eol()<cr>", { noremap = true })
  vim.keymap.set("x", "t", "<cmd>lua require('substitute').visual()<cr>", { noremap = true })
  vim.notify "Substitute setup"

  vim.keymap.set("n", "tx", "<cmd>lua require('substitute.exchange').operator()<cr>", { noremap = true })
  vim.keymap.set("n", "txx", "<cmd>lua require('substitute.exchange').line()<cr>", { noremap = true })
  vim.keymap.set("x", "X", "<cmd>lua require('substitute.exchange').visual()<cr>", { noremap = true })
  vim.keymap.set("n", "txc", "<cmd>lua require('substitute.exchange').cancel()<cr>", { noremap = true })
end

return M
