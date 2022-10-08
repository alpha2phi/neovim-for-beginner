local null_ls = require "null-ls"
local helpers = require "null-ls.helpers"

local refurb = {
  name = "refurb",
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { "python" },
  -- null_ls.generator creates an async source
  -- that spawns the command with the given arguments and options
  generator = null_ls.generator {
    command = "refurb",
    args = { "--quiet", "$FILENAME" },
    from_stderr = true,
    format = "line",
    check_exit_code = function(code, stderr)
      local success = code <= 1
      if not success then
        print(stderr)
      end
      return success
    end,
    on_output = helpers.diagnostics.from_patterns {
      {
        -- pattern = [[([%w-/.]+):(%d+):(%d+) (.*)]],
        pattern = [[:(%d+):(%d+) (.*)]],
        groups = { "row", "col", "message" },
      },
    },
  },
}

null_ls.register(refurb)

return refurb
