local M = {}

local ls = require "luasnip"

function M.setup()
  return {
    ls.parser.parse_snippet("lm", "local M = {}\n\nfunction M.setup()\n  $1 \nend\n\nreturn M"),
    -- s("lm", { t { "local M = {}", "", "function M.setup()", "" }, i(1, ""), t { "", "end", "", "return M" } }),
  }
end

return M
