local M = {}

function M.setup()
  local luasnip = require "luasnip"

  luasnip.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
  }

  require("luasnip/loaders/from_vscode").load()
end

return M
