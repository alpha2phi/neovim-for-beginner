local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
-- local isn = ls.indent_snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
-- local events = require "luasnip.util.events"
-- local types = require "luasnip.util.types"
local f = ls.function_node
local d = ls.dynamic_node
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
local p = require("luasnip.extras").partial
-- local rep = require("luasnip.extras").rep
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local conds = require "luasnip.extras.expand_conditions"

local function bash(_, snip)
  local file = io.popen(snip.trigger, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

local snippets = {
  s({ trig = "ymd", name = "Current date", dscr = "Insert the current date" }, {
    p(os.date, "%Y-%m-%d"),
  }),

  s({ trig = "pwd" }, { f(bash, {}) }),
  s("choice", { c(1, { t "choice 1", t "choice 2", t "choice 3" }) }),

  s(
    "dt",
    f(function()
      return os.date "%D - %H:%M"
    end)
  ),

  s(
    "fmt2",
    fmt(
      [[
    foo({1}, {3}) {{
        return {2} * {4}
      }}
    ]],
      {
        i(1, "x"),
        rep(1),
        i(2, "y"),
        rep(2),
      }
    )
  ),

  s("yy", p(os.date, "%Y")),

  s("link_url", {
    t '<a href="',
    f(function(_, snip)
      -- TM_SELECTED_TEXT is a table to account for multiline-selections.
      -- In this case only the first line is inserted.
      return snip.env.TM_SELECTED_TEXT[1] or {}
    end, {}),
    t '">',
    i(1),
    t "</a>",
    i(0),
  }),

  s("ddd", {
    t "from: ",
    i(1),
    t { "", "to: " },
    d(2, function(args)
      -- the returned snippetNode doesn't need a position; it's inserted
      -- "inside" the dynamicNode.
      return sn(nil, {
        -- jump-indices are local to each snippetNode, so restart at 1.
        i(1, args[1]),
      })
    end, {
      1,
    }),
  }),
}

local autosnippets = {
  ls.parser.parse_snippet("$file$", "$TM_FILENAME"),
}

return snippets, autosnippets
