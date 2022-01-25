local M = {}

local servers = {
  sumneko_lua = {},
  pyright = {},
}

local function on_attach(client, bufnr)
  require("config.lsp.keymaps").setup()
end

local opts = {
  on_attach = on_attach,
  flags = {
    debounce_text_changes = 150,
  },
}

function M.setup()
  require("config.lsp.installer").setup(servers, opts)
end

return M
