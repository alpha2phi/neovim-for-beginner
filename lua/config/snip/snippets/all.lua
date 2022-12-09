local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local sn = ls.snippet_node
local rep = require("luasnip.extras").rep
local d = ls.dynamic_node
local f = ls.function_node
local p = require("luasnip.extras").partial
local fmt = require("luasnip.extras.fmt").fmt
-- local fmta = require("luasnip.extras.fmt").fmta
-- local isn = ls.indent_snippet_node
-- local events = require "luasnip.util.events"
-- local types = require "luasnip.util.types"
-- local r = ls.restore_node
-- local l = require("luasnip.extras").lambda
-- local rep = require("luasnip.extras").rep
-- local rep = require("luasnip.extras").rep
-- local m = require("luasnip.extras").match
-- local n = require("luasnip.extras").nonempty
-- local dl = require("luasnip.extras").dynamic_lambda
-- local conds = require "luasnip.extras.expand_conditions"

-- _G.luasnip = {}
-- _G.luasnip.vars = {
--   username = "alpa2phi",
--   email = "alpha2phi@gmail.com",
--   github = "https://github.com/alpha2phi",
--   real_name = "Alpa2Phi",
-- }

local function bash(_, snip)
  local file = io.popen(snip.trigger, "r")
  local res = {}
  for line in file:lines() do
    table.insert(res, line)
  end
  return res
end

-- local calculate_comment_string = require("Comment.ft").calculate
-- local region = require("Comment.utils").get_region
--
-- local get_cstring = function(ctype)
--   local cstring = calculate_comment_string { ctype = ctype, range = region() } or ""
--   local cstring_table = vim.split(cstring, "%s", { plain = true, trimempty = true })
--   if #cstring_table == 0 then
--     return { "", "" } -- default
--   end
--   return #cstring_table == 1 and { cstring_table[1], "" } or { cstring_table[1], cstring_table[2] }
-- end

-- local marks = {
--   signature = function()
--     return fmt("<{}>", i(1, _G.luasnip.vars.username))
--   end,
--   signature_with_email = function()
--     return fmt("<{}{}>", { i(1, _G.luasnip.vars.username), i(2, " " .. _G.luasnip.vars.email) })
--   end,
--   date_signature_with_email = function()
--     return fmt(
--       "<{}{}{}>",
--       { i(1, os.date "%d-%m-%y"), i(2, ", " .. _G.luasnip.vars.username), i(3, " " .. _G.luasnip.vars.email) }
--     )
--   end,
--   date_signature = function()
--     return fmt("<{}{}>", { i(1, os.date "%d-%m-%y"), i(2, ", " .. _G.luasnip.vars.username) })
--   end,
--   date = function()
--     return fmt("<{}>", i(1, os.date "%d-%m-%y"))
--   end,
--   empty = function()
--     return t ""
--   end,
-- }

-- local todo_snippet_nodes = function(aliases, opts)
--   local aliases_nodes = vim.tbl_map(function(alias)
--     return i(nil, alias) -- generate choices for [name-of-comment]
--   end, aliases)
--   local sigmark_nodes = {} -- choices for [comment-mark]
--   for _, mark in pairs(marks) do
--     table.insert(sigmark_nodes, mark())
--   end
--   -- format them into the actual snippet
--   local comment_node = fmta("<> <>: <> <> <><>", {
--     f(function()
--       return get_cstring(opts.ctype)[1] -- get <comment-string[1]>
--     end),
--     c(1, aliases_nodes), -- [name-of-comment]
--     i(3), -- {comment-text}
--     c(2, sigmark_nodes), -- [comment-mark]
--     f(function()
--       return get_cstring(opts.ctype)[2] -- get <comment-string[2]>
--     end),
--     i(0),
--   })
--   return comment_node
-- end

-- -- local todo_snippet = function(context, aliases, opts)
-- --   opts = opts or {}
-- --   aliases = type(aliases) == "string" and { aliases } or aliases -- if we do not have aliases, be smart about the function parameters
-- --   context = context or {}
-- --   if not context.trig then
-- --     return error("context doesn't include a `trig` key which is mandatory", 2) -- all we need from the context is the trigger
-- --   end
-- --   opts.ctype = opts.ctype or 1 -- comment type can be passed in the `opts` table, but if it is not, we have to ensure, it is defined
-- --   local alias_string = table.concat(aliases, "|") -- `choice_node` documentation
-- --   context.name = context.name or (alias_string .. " comment") -- generate the `name` of the snippet if not defined
-- --   context.dscr = context.dscr or (alias_string .. " comment with a signature-mark") -- generate the `dscr` if not defined
-- --   context.docstring = context.docstring or (" {1:" .. alias_string .. "}: {3} <{2:mark}>{0} ") -- generate the `docstring` if not defined
-- --   local comment_node = todo_snippet_nodes(aliases, opts) -- nodes from the previously defined function for their generation
-- --   return s(context, comment_node, opts) -- the final todo-snippet constructed from our parameters
-- -- end
-- --
-- local todo_snippet_specs = {
--   { { trig = "todo" }, "TODO" },
--   { { trig = "fix" }, { "FIX", "BUG", "ISSUE", "FIXIT" } },
--   { { trig = "hack" }, "HACK" },
--   { { trig = "warn" }, { "WARN", "WARNING", "XXX" } },
--   { { trig = "perf" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" } },
--   { { trig = "note" }, { "NOTE", "INFO" } },
--   -- NOTE: Block commented todo-comments <kunzaatko>
--   { { trig = "todob" }, "TODO", { ctype = 2 } },
--   { { trig = "fixb" }, { "FIX", "BUG", "ISSUE", "FIXIT" }, { ctype = 2 } },
--   { { trig = "hackb" }, "HACK", { ctype = 2 } },
--   { { trig = "warnb" }, { "WARN", "WARNING", "XXX" }, { ctype = 2 } },
--   { { trig = "perfb" }, { "PERF", "PERFORMANCE", "OPTIM", "OPTIMIZE" }, { ctype = 2 } },
--   { { trig = "noteb" }, { "NOTE", "INFO" }, { ctype = 2 } },
-- }

-- local todo_comment_snippets = {}
-- for _, v in ipairs(todo_snippet_specs) do
--   table.insert(todo_comment_snippets, todo_snippet(v[1], v[2], v[3]))
-- end

-- ls.add_snippets("all", todo_comment_snippets, { type = "snippets", key = "todo_comments" })

---------------------------- Snippets  ------------------------------------------------
local snippets = {
  s({ trig = "ymd", name = "Current date", dscr = "Insert the current date" }, {
    p(os.date, "%Y-%m-%d"),
  }),

  -- s({ trig = "pwd" }, { f(bash, {}) }),

  s("choice", { c(1, { t "choice 1", t "choice 2", t "choice 3" }) }),

  s(
    "$date",
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

  s("dn", {
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

  s(
    "sn",
    sn(1, {
      t { "Select a choice : " },
      c(1, { t "choice 1", t "choice 2", t "choice 3" }),
    })
  ),
  s("mlink", {
    t "[",
    i(1),
    t "](",
    f(function(_, snip)
      return snip.env.TM_SELECTED_TEXT[1] or {}
    end, {}),
    t ")",
    i(0),
  }),
}

-- local autosnippets = {
--   ls.parser.parse_snippet("$file$", "$TM_FILENAME"),
-- }

return snippets -- , autosnippets
