local M = {}

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

return M
