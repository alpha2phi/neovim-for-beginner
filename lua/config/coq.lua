local M = {}

function M.setup()
  local coq = require "coq"
  coq.Now() -- Start coq

  -- 3party sources
  require "coq_3p" {
    { src = "nvimlua", short_name = "LUA" }, -- Lua source
    { src = "bc", short_name = "MATH", precision = 6 }, -- Calculator
    { src = "cow", trigger = "!cow", short_name = "COW" }, -- cow command
    { src = "figlet", short_name = "FIGLET" }, -- figlet command
  }
end

return M
