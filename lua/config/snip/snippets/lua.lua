local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node

local snippets = {
  ls.parser.parse_snippet("lm", "local M = {}\n\nfunction M.setup()\n  $1 \nend\n\nreturn M"),
  -- s("lm", { t { "local M = {}", "", "function M.setup()", "" }, i(1, ""), t { "", "end", "", "return M" } }),
  s("todo", t "print('TODO')"),
}

return snippets
