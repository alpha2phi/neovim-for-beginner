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
    keywords = {
      FIX = { icon = icons.ui.Bug, color = error_red },
      TODO = { icon = icons.ui.Check, color = hint_blue },
      HACK = { icon = icons.ui.Fire, color = warning_orange },
      WARN = { icon = icons.diagnostics.Warning, color = warning_orange },
      PERF = { icon = icons.ui.Dashboard, color = perf_purple },
      NOTE = { icon = icons.ui.Note, color = info_yellow },
    },
  }
end

return M
