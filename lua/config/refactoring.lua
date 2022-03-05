local M = {}

local function keymaps()
  print "configure keymap"
end

function M.setup()
  require("refactoring").setup {
    -- prompt for return type
    prompt_func_return_type = {
      go = true,
    },
    -- prompt for function parameters
    prompt_func_param_type = {
      go = true,
    },
  }
end

return M
