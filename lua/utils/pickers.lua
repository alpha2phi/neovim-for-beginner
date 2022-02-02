local M = {}

-- Themes to use
local dropdown_theme = require("telescope.themes").get_dropdown {}
local ivy_theme = require("telescope.themes").get_ivy {}
local cursor_theme = require("telescope.themes").get_cursor {}
local custom_theme = require("telescope.themes").get_dropdown {
  results_height = 20,
  winblend = 20,
  width = 0.8,
  prompt_title = "",
  prompt_prefix = "   ",
  previewer = false,
  color_devicons = true,
  border = {},
  borderchars = {
    prompt = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
    results = { " ", "▐", "▄", "▌", "▌", "▐", "▟", "▙" },
    preview = { "▀", "▐", "▄", "▌", "▛", "▜", "▟", "▙" },
  },
}

-- Custom pickers
local custom_pickers = {
  dotfiles = {
    theme = custom_theme,
    cwd = "$HOME/workspace/alpha2phi/neovim-for-beginner/",
    fun = "fd",
  },
}

-- Display the picker
function M.run(fun, opts)
  opts = opts or {}
  local options
  local picker = custom_pickers[fun]
  if not picker then
    options = dropdown_theme
    options = vim.tbl_extend("force", options, opts)
  else
    local theme
    options = vim.deepcopy(picker)
    fun = options.fun
    theme = options.theme
    options.theme = nil
    options.fun = nil
    options = vim.tbl_extend("force", theme, options)
  end
  return require("telescope.builtin")[fun](options)
end

return M
