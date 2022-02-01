local M = {}

-- Dropdown list theme using a builtin theme definitions :
local center_list = require("telescope.themes").get_dropdown {
  winblend = 10,
  width = 0.5,
  prompt = " ",
  results_height = 15,
  previewer = false,
}

-- Settings for with preview option
local with_preview = {
  winblend = 10,
  show_line = false,
  results_title = false,
  preview_title = false,
  layout_config = {
    preview_width = 0.5,
  },
}

local telescopes = {
  fd_nvim = {
    prompt_prefix = "Nvim>",
    fun = "fd",
    theme = center_list,
    cwd = vim.fn.stdpath("config")
    -- .. other options
  }
  fd = {
    prompt_prefix = "Files>",
    fun = "fd",
    theme = with_preview,
    -- .. other options
  }
}

function M.run(str, theme)
  local base, fun, opts
  if not telescopes[str] then
    fun = str
    opts = theme or {}
    --return print("Sorry not found")
  else
    base = telescopes[str]
    fun = base.fun; theme = base.theme
    base.theme = nil; base.fun = nil
    opts = vim.tbl_extend("force", theme, base)
  end
  if str then
    return require"telescope.builtin"[fun](opts)
  else
    return print("You need to a set a default function")
    -- return require"telescope.builtin".find_files(opts)
  end
end

return M
