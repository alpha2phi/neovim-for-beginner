local M = {}

function M.setup()
  -- https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/ai.lua
  -- require("mini.ai").setup {
  --   custom_textobjects = {
  --     b = require("mini.ai").gen_spec.argument { brackets = { "%b()", "^.%s*().-()%s*.$" } },
  --     B = require("mini.ai").gen_spec.argument { brackets = { "%b{}", "^.%s*().-()%s*.$" } },
  --     r = require("mini.ai").gen_spec.argument { brackets = { "%b[]", "^.%s*().-()%s*.$" } },
  --   },
  --   search_method = "cover_or_next",
  -- }
  require("mini.align").setup()
  require("mini.test").setup()
  require("mini.doc").setup()
  -- require("mini.jump").setup {}
end

return M
