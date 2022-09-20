local M = {}

local colors = require "config.colors"
local set_hl = vim.api.nvim_set_hl

function M.setup()
  require("nvim-semantic-tokens").setup {
    preset = "default",
    -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
    -- function with the signature: highlight_token(ctx, token, highlight) where
    --        ctx (as defined in :h lsp-handler)
    --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
    --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
    highlighters = { require "nvim-semantic-tokens.table-highlighter" },
  }
  set_hl(0, "LspParameter", { fg = colors.blue })
  set_hl(0, "LspType", { fg = colors.pink })
end

return M
