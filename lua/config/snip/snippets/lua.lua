local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
-- local c = ls.choice_node
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node

local snippets = {
  ls.parser.parse_snippet("lm", "local M = {}\n\nfunction M.setup()\n  $1 \nend\n\nreturn M"),
  -- s("lm", { t { "local M = {}", "", "function M.setup()", "" }, i(1, ""), t { "", "end", "", "return M" } }),
  s("todo", t "print('TODO')"),
  s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
}

return snippets
