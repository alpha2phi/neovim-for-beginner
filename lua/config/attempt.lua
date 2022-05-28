local M = {}

function M.setup()
  require("attempt").setup()
  require("telescope").load_extension "attempt"
end

return M
