local M = {}

local icons = require "config.icons"

function M.setup()
  local notify = require "notify"
  notify.setup {
    stages = "fade_in_slide_out",
    on_open = nil,
    on_close = nil,
    render = "default",
    timeout = 175,
    background_colour = "Normal",
    minimum_width = 10,
    icons = {
      ERROR = icons.diagnostics.Error,
      WARN = icons.diagnostics.Warning,
      INFO = icons.diagnostics.Information,
      DEBUG = icons.ui.Bug,
      TRACE = icons.ui.Pencil,
    },
  }
  vim.notify = notify
end

return M
