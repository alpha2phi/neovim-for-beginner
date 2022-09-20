local M = {}

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

  -- token
  set_hl(0, "LspNamespace", { fg = "" })
  set_hl(0, "LspType", { link = "TSType" })
  set_hl(0, "LspClass", { fg = "" })
  set_hl(0, "LspEnum", { fg = "" })
  set_hl(0, "LspInterface", { fg = "" })
  set_hl(0, "LspStruct", { fg = "" })
  set_hl(0, "LspTypeParameter", { fg = "" })
  set_hl(0, "LspParameter", { link = "TSParameter" })
  set_hl(0, "LspVariable", { fg = "" })
  set_hl(0, "LspProperty", { fg = "" })
  set_hl(0, "LspEnumMember", { fg = "" })
  set_hl(0, "LspEvent", { fg = "" })
  set_hl(0, "LspFunction", { fg = "" })
  set_hl(0, "LspMethod", { fg = "" })
  set_hl(0, "LspMacro", { fg = "" })
  set_hl(0, "LspKeyword", { fg = "" })
  set_hl(0, "LspModifier", { fg = "" })
  set_hl(0, "LspComment", { fg = "" })
  set_hl(0, "LspString", { fg = "" })
  set_hl(0, "LspNumber", { fg = "" })
  set_hl(0, "LspRegexp", { fg = "" })
  set_hl(0, "LspOperator", { fg = "" })
  set_hl(0, "LspDecorator", { fg = "" })

  -- modifier
  set_hl(0, "LspDeclaration", { fg = "" })
  set_hl(0, "LspDefinition", { fg = "" })
  set_hl(0, "LspReadonly", { fg = "" })
  set_hl(0, "LspStatic", { fg = "" })
  set_hl(0, "LspDeprecated", { fg = "" })
  set_hl(0, "LspAbstract", { fg = "" })
  set_hl(0, "LspAsync", { fg = "" })
  set_hl(0, "LspModification", { fg = "" })
  set_hl(0, "LspDocumentation", { fg = "" })
  set_hl(0, "LspDefaultLibrary", { fg = "" })
end

return M
