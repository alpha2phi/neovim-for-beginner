local M = {}

local set_hl = vim.api.nvim_set_hl

function M.setup()
  -- token
  -- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/lua/nvim-treesitter/highlight.lua
  set_hl(0, "LspParameter", { fg = "#ef9062" })
  set_hl(0, "LspType", { fg = "#619e9d" })
  -- set_hl(0, "LspParameter", { link = "TSParameter" })
  -- set_hl(0, "LspType", { link = "TSType" })
  set_hl(0, "LspClass", { link = "TSStorageClass" })
  set_hl(0, "LspComment", { link = "TSComment" })
  set_hl(0, "LspDecorator", { link = "TSAnnotation" })
  set_hl(0, "LspEnum", { link = "TSType" })
  set_hl(0, "LspEnumMember", { link = "TSParameter" })
  set_hl(0, "LspEvent", { link = "TSProperty" })
  set_hl(0, "LspFunction", { link = "TSFunction" })
  set_hl(0, "LspInterface", { link = "TSKeywordFunction" })
  set_hl(0, "LspKeyword", { link = "TSKeyword" })
  set_hl(0, "LspMacro", { link = "TSFuncMacro" })
  set_hl(0, "LspMethod", { link = "TSMethod" })
  set_hl(0, "LspModifier", { link = "TSTypeQualifier" })
  set_hl(0, "LspNamespace", { link = "TSNamespace" })
  set_hl(0, "LspNumber", { link = "TSNumber" })
  set_hl(0, "LspOperator", { link = "TSOperator" })
  set_hl(0, "LspProperty", { link = "TSProperty" })
  set_hl(0, "LspRegexp", { link = "TSStringRegex" })
  set_hl(0, "LspString", { link = "TSString" })
  set_hl(0, "LspStruct", { link = "TSTypeDefinition" })
  set_hl(0, "LspTypeParameter", { link = "TSType" })
  set_hl(0, "LspVariable", { link = "TSVariable" })

  -- modifier
  -- set_hl(0, "LspDeclaration", { link = "TSDefine" })
  -- set_hl(0, "LspDefinition", { link = "TSTypeDefinition" })
  -- set_hl(0, "LspReadonly", { link = "TSContant" })
  -- set_hl(0, "LspStatic", { link = "TSConsantMacro" })
  -- set_hl(0, "LspDeprecated", { link = "TSWarning" })
  -- set_hl(0, "LspAbstract", { fg = "#9E6162" })
  -- set_hl(0, "LspAsync", { fg = "#81A35C" })
  -- set_hl(0, "LspModification", { fg = "#7E5CA3" })
  -- set_hl(0, "LspDocumentation", { fg = "#ccc0f5" })
  -- set_hl(0, "LspDefaultLibrary", { fg = "#c99dc1" })

  require("nvim-semantic-tokens").setup {
    preset = "default",
    -- highlighters is a list of modules following the interface of nvim-semantic-tokens.table-highlighter or
    -- function with the signature: highlight_token(ctx, token, highlight) where
    --        ctx (as defined in :h lsp-handler)
    --        token  (as defined in :h vim.lsp.semantic_tokens.on_full())
    --        highlight (a helper function that you can call (also multiple times) with the determined highlight group(s) as the only parameter)
    highlighters = { require "nvim-semantic-tokens.table-highlighter" },
  }
end

return M
