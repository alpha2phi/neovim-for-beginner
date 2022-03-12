local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local snippets = {
  s("shebang", {
    t { "#!/usr/bin/env python", "" },
    i(0),
  }),
}

return snippets
