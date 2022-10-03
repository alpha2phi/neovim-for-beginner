local M = {}

local navic = require "nvim-navic"
local utils = require "utils"
local icons = require "config.icons"

local function get_modified()
  local file_name = vim.fn.expand "%:t"
  local extension = vim.fn.expand "%:e"

  if file_name then
    local file_icon, file_icon_color = require("nvim-web-devicons").get_icon_color(
      file_name,
      extension,
      { default = true }
    )
    local hl_group = "FileIconColor" .. extension
    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if not file_icon then
      file_icon = icons.winbar.FileIcon
    end

    if utils.get_buf_option "mod" then
      local mod = icons.git.Mod
      return mod .. " " .. "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. file_name
    end
    return "%#" .. hl_group .. "#" .. file_icon .. "%*" .. " " .. file_name
  end
end

local function get_location()
  local location = navic.get_location()
  if not utils.is_empty(location) then
    return " " .. icons.ui.ChevronRight .. " " .. location
  end
  return ""
end

function M.get_winbar()
  if navic.is_available() then
    return get_modified() .. get_location()
  else
    return get_modified()
  end
end

return M
