local M = {}

local python_function_query_string = [[
  (function_definition 
    name: (identifier) @name (#offset! @name)
  ) @func
]]

-- local ts_locals = require "nvim-treesitter.locals"
-- local ts_utils = require "nvim-treesitter.ts_utils"
-- local q = require "vim.treesitter.query"

local bufnr_test = 28

function M.get_functions(bufnr, lang, query_string)
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local syntax_tree = parser:parse()[1]
  local root = syntax_tree:root()
  local query = vim.treesitter.parse_query(lang, query_string)

  -- for id, node in query:iter_captures(root, bufnr, 0, -1) do
  --   dump(q.get_node_text(node, bufnr))
  -- end
  -- dump(q)
  
  local func_info = {}

  for _, captures, metadata in query:iter_matches(root, bufnr) do
    local row, col, _ = captures[1]:start()
    local name = vim.treesitter.query.get_node_text(captures[1], bufnr)
    -- dump(metadata[1].range)
    table.insert(func_info, {name, row, col})
  end
  vim.pretty_print(func_info)
end

M.get_functions(bufnr_test, "python", python_function_query_string)

return M
