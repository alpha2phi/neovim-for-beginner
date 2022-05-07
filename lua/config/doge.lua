local M = {}

function M.setup()
  vim.g.doge_enable_mappings = 1
  vim.g.doge_doc_standard_python = "google"
  vim.g.doge_doc_standard_javascript = "jsdoc"
  vim.g.doge_doc_standard_typescript = "jsdoc"
  vim.g.doge_doc_standard_rs = "rustdoc"
end

return M
