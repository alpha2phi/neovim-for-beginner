local h = require "null-ls.helpers"
local nls = require "null-ls"

local DIAGNOSTICS = nls.methods.DIAGNOSTICS

local refurb = {
  name = "refurb",
  method = DIAGNOSTICS,
  filetypes = { "python" },
  generator = nls.generator {
    command = "refurb",
    to_stdin = false,
    from_stderr = false,
    args = { "--quiet", "$FILENAME" },
    format = "line",
    check_exit_code = function(code, stderr)
      local success = code <= 1
      if not success then
        print(stderr)
      end
      return success
    end,
    on_output = h.diagnostics.from_pattern([[:(%d+):(%d+) (.*)]], { "row", "col", "message" }),
  },
  factory = h.generator_factory,
}

nls.register(refurb)

return refurb
