local M = {}

function M.setup()
  require("project_nvim").setup {
    detection_methods = { "pattern", "lsp" },
    patterns = { ".git" },
  }
end

return M
