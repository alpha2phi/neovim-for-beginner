local M = {}

local python_function_query_string = [[
  (function_definition 
    name: (identifier) @func_name (#offset! @func_name)
  ) 
]]

local lua_function_query_string = [[
  (function_declaration
  name: 
    [
      (dot_index_expression) 
      (identifier) 
    ] @func_name (#offset! @func_name) 
  ) 
]]

local func_lookup = {
  python = python_function_query_string,
  lua = lua_function_query_string,
}

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
  bufnr = bufnr or vim.api.nvim_get_current_buf()
  lang = lang or vim.api.nvim_buf_get_option(bufnr, "filetype")

  local query_string = func_lookup[lang]
  if not query_string then
    vim.notify(lang .. " is not supported", vim.log.levels.INFO)
    return
  end
  local func_list = get_functions(bufnr, lang, query_string)
  if vim.tbl_isempty(func_list) then
    return
  end
  local funcs = {}
  for _, func in ipairs(func_list) do
    table.insert(funcs, func[1])
  end
  vim.ui.select(funcs, {
    prompt = "Select a function:",
    format_item = function(item)
      return "Function - " .. item
    end,
  }, function(_, idx)
    if not idx then
      return
    end
    local goto_function = func_list[idx]
    local row, col = goto_function[2] + 1, goto_function[3] + 2
    vim.fn.setcharpos(".", { bufnr, row, col, 0 })
    vim.cmd [[normal! zz]]
  end)
end

-- M.goto_function(bufnr_test, "python")
-- M.goto_function()

return M
