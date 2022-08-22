local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local d = ls.dynamic_node
local c = ls.choice_node
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local fmt = require("luasnip.extras.fmt").fmt
local types = require "luasnip.util.types"
local events = require "luasnip.util.events"
local r = ls.restore_node

local function node_with_virtual_text(pos, node, text)
  local nodes
  if node.type == types.textNode then
    node.pos = 2
    nodes = { i(1), node }
  else
    node.pos = 1
    nodes = { node }
  end
  return sn(pos, nodes, {
    callbacks = {
      -- node has pos 1 inside the snippetNode.
      [1] = {
        [events.enter] = function(nd)
          -- node_pos: {line, column}
          local node_pos = nd.mark:pos_begin()
          -- reuse luasnips namespace, column doesn't matter, just 0 it.
          nd.virt_text_id = vim.api.nvim_buf_set_extmark(0, ls.session.ns_id, node_pos[1], 0, {
            virt_text = { { text, "GruvboxOrange" } },
          })
        end,
        [events.leave] = function(nd)
          vim.api.nvim_buf_del_extmark(0, ls.session.ns_id, nd.virt_text_id)
        end,
      },
    },
  })
end

local function nodes_with_virtual_text(nodes, opts)
  if opts == nil then
    opts = {}
  end
  local new_nodes = {}
  for pos, node in ipairs(nodes) do
    if opts.texts[pos] ~= nil then
      node = node_with_virtual_text(pos, node, opts.texts[pos])
    end
    table.insert(new_nodes, node)
  end
  return new_nodes
end

local function choice_text_node(pos, choices, opts)
  choices = nodes_with_virtual_text(choices, opts)
  return c(pos, choices, opts)
end

local ct = choice_text_node

local function py_init()
  return c(1, {
    t "",
    sn(1, {
      t ", ",
      i(1),
      d(2, py_init),
    }),
  })
end

-- splits the string of the comma separated argument list into the arguments
-- and returns the text-/insert- or restore-nodes
local function to_init_assign(args)
  local tab = {}
  local a = args[1][1]
  if #a == 0 then
    table.insert(tab, t { "", "\tpass" })
  else
    local cnt = 1
    for e in string.gmatch(a, " ?([^,]*) ?") do
      if #e > 0 then
        table.insert(tab, t { "", "\tself." })
        -- use a restore-node to be able to keep the possibly changed attribute name
        -- (otherwise this function would always restore the default, even if the user
        -- changed the name)
        table.insert(tab, r(cnt, tostring(cnt), i(nil, e)))
        table.insert(tab, t " = ")
        table.insert(tab, t(e))
        cnt = cnt + 1
      end
    end
  end
  return sn(nil, tab)
end

-- create the actual snippet
local snippets = {
  s("shebang", {
    t { "#!/usr/bin/env python", "" },
    i(0),
  }),
  s("ti", {
    t { "# type: ignore" },
    i(0),
  }),
  s(
    "pydef",
    fmt(
      [[
            def {func}({args}){ret}:
                {doc}{body}
        ]],
      {
        func = i(1),
        args = i(2),
        ret = c(3, {
          t "",
          sn(nil, {
            t " -> ",
            i(1),
          }),
        }),
        doc = isn(4, {
          ct(1, {
            t "",
            -- NOTE we need to surround the `fmt` with `sn` to make this work
            sn(
              1,
              fmt(
                [[
                """{desc}"""

                ]],
                { desc = i(1) }
              )
            ),
            sn(
              2,
              fmt(
                [[
                """{desc}

                Args:
                {args}

                Returns:
                {returns}
                """

                ]],
                {
                  desc = i(1),
                  args = i(2), -- TODO should read from the args in the function
                  returns = i(3),
                }
              )
            ),
          }, {
            texts = {
              "(no docstring)",
              "(single line docstring)",
              "(full docstring)",
            },
          }),
        }, "$PARENT_INDENT\t"),
        body = i(0),
      }
    )
  ),
  s(
    "pyinit",
    fmt([[def __init__(self{}):{}]], {
      d(1, py_init),
      d(2, to_init_assign, { 1 }),
    })
  ),
}

return snippets
