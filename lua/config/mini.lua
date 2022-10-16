local M = {}

function M.setup()
  -- https://github.com/echasnovski/mini.nvim/blob/main/lua/mini/ai.lua
  require("mini.ai").setup {
    custom_textobjects = {
      b = require("mini.ai").gen_spec.argument { brackets = { "%b()" }, "^.().*().$" },
      B = require("mini.ai").gen_spec.argument { brackets = { "%b{}" }, "^.().*().$" },
      r = require("mini.ai").gen_spec.argument { brackets = { "%b[]" }, "^.().*().$" },
    },
  }
  require("mini.align").setup {}
  require("mini.jump").setup {}
end

return M
