local M = {}

function M.setup()
  vim.notify "Setting up flutter..."
  require("flutter-tools").setup {
    lsp = {
      on_attach = require("config.lsp").on_attach,
      capabilities = require("config.lsp").capabilities,
    },
  }
  require("telescope").load_extension "flutter"
end

return M
