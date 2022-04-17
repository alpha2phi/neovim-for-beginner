local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local l = require("luasnip.extras").lambda
local f = ls.function_node

-- local c = ls.choice_node
-- local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node

local snippets = {
  ls.parser.parse_snippet("lm", "local M = {}\n\nfunction M.setup()\n  $1 \nend\n\nreturn M"),
  -- s("lm", { t { "local M = {}", "", "function M.setup()", "" }, i(1, ""), t { "", "end", "", "return M" } }),

  s("todo", t 'print("TODO")'),

  -- s("req", fmt("local {} = require('{}')", { i(1, "default"), rep(1) })),
  s(
    "localreq1",
    fmt('local {} = require("{}")', {
      l(l._1:match("[^.]*$"):gsub("[^%a]+", "_"), 1),
      i(1, "module"),
    })
  ),
  s(
    "localreq2",
    fmt([[local {} = require "{}"]], {
      f(function(import_name)
        local parts = vim.split(import_name[1][1], ".", true)
        return parts[#parts] or ""
      end, {
        1,
      }),
      i(1),
    })
  ),

  s(
    "preq",
    fmt('local {1}_ok, {1} = pcall(require, "{}")\nif not {1}_ok then return end', {
      l(l._1:match("[^.]*$"):gsub("[^%a]+", "_"), 1),
      i(1, "module"),
    })
  ),
}
return snippets
