local M = {}

function M.setup()
  require("lspsaga").init_lsp_saga {
    symbol_in_winbar = {
      in_custom = false,
    },
  }
end

return M
