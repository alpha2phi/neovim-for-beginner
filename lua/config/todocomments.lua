local M = {}

local icons = require "config.icons"

local error_red = "#F44747"
local warning_orange = "#ff8800"
local info_yellow = "#FFCC66"
local hint_blue = "#4FC1FF"
local perf_purple = "#7C3AED"

function M.setup()
  require("todo-comments").setup {
    signs = true,
    sign_priority = 8,
    keywords = {
      FIX = {
        icon = icons.ui.Bug,
        color = error_red,
        alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
      },
      TODO = { icon = icons.ui.Check, color = hint_blue, alt = { "TIP" } },
      HACK = { icon = icons.ui.Fire, color = warning_orange },
      WARN = { icon = icons.diagnostics.Warning, color = warning_orange, alt = { "WARNING", "XXX" } },
      PERF = { icon = icons.ui.Dashboard, color = perf_purple, alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
      NOTE = { icon = icons.ui.Note, color = info_yellow, alt = { "INFO" } },
    },
  }
end

return M
