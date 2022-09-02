local M = {}

local python_function_query_string = [[
  (function_definition 
    name: (identifier) @name (#offset! @name)
  ) @func
]]

local lua_function_query_string = [[
 TODO
]]

local func_lookup = {
  python = python_function_query_string,
  lua = lua_function_query_string,
}

local bufnr_test = 28

local function get_functions(bufnr, lang, query_string)
  local parser = vim.treesitter.get_parser(bufnr, lang)
  local syntax_tree = parser:parse()[1]
  local root = syntax_tree:root()
  local query = vim.treesitter.parse_query(lang, query_string)
  local func_list = {}

  for _, captures, metadata in query:iter_matches(root, bufnr) do
    local row, col, _ = captures[1]:start()
    local name = vim.treesitter.query.get_node_text(captures[1], bufnr)
    table.insert(func_list, { name, row, col, metadata[1].range })
  end
  return func_list
end

function M.goto_function(bufnr, lang)
  local query_string = func_lookup[lang]
  if not query_string then
    vim.notify(lang .. " is not supported", vim.log.levels.INFO)
  end
  local func_list = get_functions(bufnr, lang, query_string)
  if vim.tbl_isempty(func_list) then
    return
  end
  dump(func_list)
end

M.goto_function(bufnr_test, "python")

return M
