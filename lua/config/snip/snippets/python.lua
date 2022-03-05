local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node

local snippets = {
  s("hello", t "Testing Python"),
}

return snippets
