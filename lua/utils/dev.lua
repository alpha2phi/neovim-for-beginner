local M = {}

local api = vim.api
local parsers = require "nvim-treesitter.parsers"
local ts_utils = require "nvim-treesitter.ts_utils"
local highlighter = vim.treesitter.highlighter

local defaultConfig = {
  enable = true,
  max_lines = 0, -- no limit
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to collapse for a single context line
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  zindex = 20,
  mode = "cursor", -- Choices: 'cursor', 'topline'
  separator = nil,
}

local function word_pattern(p)
  return "%f[%w]" .. p .. "%f[^%w]"
end

local config = defaultConfig

local DEFAULT_TYPE_PATTERNS = {
  -- These catch most generic groups, eg "function_declaration" or "function_block"
  default = {
    "class",
    "function",
    "method",
    "for",
    "while",
    "if",
    "switch",
    "case",
  },
  tex = {
    "chapter",
    "section",
    "subsection",
    "subsubsection",
  },
  rust = {
    "impl_item",
    "struct",
    "enum",
  },
  scala = {
    "object_definition",
  },
  vhdl = {
    "process_statement",
    "architecture_body",
    "entity_declaration",
  },
  markdown = {
    "section",
  },
  elixir = {
    "anonymous_function",
    "arguments",
    "block",
    "do_block",
    "list",
    "map",
    "tuple",
    "quoted_content",
  },
  exact_patterns = {},
}

local DEFAULT_TYPE_EXCLUDE_PATTERNS = {
  default = {},
  teal = {
    "function_body",
  },
}

config.patterns = DEFAULT_TYPE_PATTERNS
config.exclude_patterns = DEFAULT_TYPE_EXCLUDE_PATTERNS
config.exact_patterns = {}

for filetype, patterns in pairs(config.patterns) do
  -- Map with word_pattern only if users don't need exact pattern matching
  if not config.exact_patterns[filetype] then
    config.patterns[filetype] = vim.tbl_map(word_pattern, patterns)
  end
end

local function get_root_node()
  local tree = parsers.get_parser():parse()[1]
  return tree:root()
end

local function calc_max_lines(config_max)
  local max_lines = config_max
  max_lines = max_lines == 0 and -1 or max_lines

  local wintop = vim.fn.line "w0"
  local cursor = vim.fn.line "."
  local max_from_cursor = cursor - wintop

  if config.separator and max_from_cursor > 0 then
    max_from_cursor = max_from_cursor - 1 -- separator takes 1 line
  end

  if max_lines ~= -1 then
    max_lines = math.min(max_lines, max_from_cursor)
  else
    max_lines = max_from_cursor
  end

  return max_lines
end

local function is_excluded(node, filetype)
  local node_type = node:type()
  for _, rgx in ipairs(config.exclude_patterns.default) do
    if node_type:find(rgx) then
      return true
    end
  end
  local filetype_patterns = config.exclude_patterns[filetype]
  for _, rgx in ipairs(filetype_patterns or {}) do
    if node_type:find(rgx) then
      return true
    end
  end
  return false
end

local function is_valid(node, filetype)
  if is_excluded(node, filetype) then
    return false
  end

  local node_type = node:type()
  for _, rgx in ipairs(config.patterns.default) do
    if node_type:find(rgx) then
      return true
    end
  end
  local filetype_patterns = config.patterns[filetype]
  for _, rgx in ipairs(filetype_patterns or {}) do
    if node_type:find(rgx) then
      return true
    end
  end
  return false
end

local function get_parent_matches(max_lines)
  if max_lines == 0 then
    return
  end

  if not parsers.has_parser() then
    return
  end

  local root_node = get_root_node()
  local lnum, col
  if config.mode == "topline" then
    lnum, col = vim.fn.line "w0", 0
  else -- default to 'cursor'
    lnum, col = unpack(api.nvim_win_get_cursor(0))
  end

  local last_matches
  local parent_matches = {}
  local line_offset = 0

  repeat
    local offset_lnum = lnum + line_offset - 1
    local node = root_node:named_descendant_for_range(offset_lnum, col, offset_lnum, col)
    if not node then
      return
    end

    last_matches = parent_matches
    parent_matches = {}
    local last_row = -1
    local topline = vim.fn.line "w0"

    -- save nodes in a table to iterate from top to bottom
    local parents = {}
    while node ~= nil do
      parents[#parents + 1] = node
      node = node:parent()
    end

    for i = #parents, 1, -1 do
      local parent = parents[i]
      local row = parent:start()

      local height = math.min(max_lines, #parent_matches)
      if is_valid(parent, vim.bo.filetype) and row >= 0 and row < (topline + height - 1) then
        if row == last_row then
          parent_matches[#parent_matches] = parent
        else
          table.insert(parent_matches, parent)
          last_row = row

          local new_height = math.min(max_lines, #parent_matches)
          if config.mode == "topline" and line_offset < new_height then
            line_offset = line_offset + 1
            break
          end
        end
      end
    end
  until config.mode ~= "topline" or #last_matches >= #parent_matches

  if config.trim_scope == "inner" then
    return vim.list_slice(parent_matches, 1, math.min(#parent_matches, max_lines))
  else -- default to 'outer'
    return vim.list_slice(parent_matches, math.max(1, #parent_matches - max_lines + 1), #parent_matches)
  end
end

function M.reload_modules()
  local lua_dirs = vim.fn.glob("./lua/*", 0, 1)
  for _, dir in ipairs(lua_dirs) do
    dir = string.gsub(dir, "./lua/", "")
    require("plenary.reload").reload_module(dir)
  end
end

function M.reload_module(name)
  require("plenary.reload").reload_module(name)
end

dump(getmetatable(get_parent_matches(calc_max_lines(config.max_lines))))

return M
