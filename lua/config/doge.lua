local M = {}

function M.setup()
  vim.g.doge_enable_mappings = 1
  vim.g.doge_doc_standard_lua = "ldoc"
  vim.g.doge_doc_standard_python = "google"
  vim.g.doge_doc_standard_javascript = "jsdoc"
  vim.g.doge_doc_standard_typescript = "jsdoc"
  vim.g.doge_doc_standard_rs = "rustdoc"
  vim.g.doge_mapping_comment_jump_forward = "<C-j>"
  vim.g.doge_mapping_comment_jump_backward = "<C-k>"
  vim.g.doge_buffer_mappings = 1
  vim.g.doge_comment_jump_modes = { "n", "i", "s" }
  vim.g.doge_mapping = ""
end

return M
