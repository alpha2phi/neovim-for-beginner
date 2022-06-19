local M = {}

local colors = require "config.colors"
local navic = require "nvim-navic"
local utils = require "utils"
local icons = require "config.icons"

vim.api.nvim_set_hl(0, "WinBarSeparator", { fg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarFilename", { fg = colors.green, bg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarContext", { fg = colors.green, bg = colors.grey })

M.winbar_filetype_exclude = {
  "help",
  "startify",
  "dashboard",
  "packer",
  "neogitstatus",
  "NvimTree",
  "Trouble",
  "alpha",
  "lir",
  "Outline",
  "spectre_panel",
  "toggleterm",
}

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

local function get_modified()
  if utils.get_buf_option "mod" then
    local mod = icons.git.Mod
    return "%#WinBarFilename#" .. mod .. " " .. "%t" .. "%*"
  end
  return "%#WinBarFilename#" .. "%t" .. "%*"
end

local function get_location()
  local location = navic.get_location()
  if not utils.is_empty(location) then
    return "%#WinBarContext#" .. " " .. icons.ui.ChevronRight .. " " .. location .. "%*"
  end
  return ""
end

function M.get_winbar()
  if excludes() then
    return ""
  end
  if navic.is_available() then
    return "%#WinBarSeparator#"
      .. "%="
      .. ""
      .. "%*"
      .. get_modified()
      .. get_location()
      .. "%#WinBarSeparator#"
      .. ""
      .. "%*"
  else
    return "%#WinBarSeparator#" .. "%=" .. "" .. "%*" .. get_modified() .. "%#WinBarSeparator#" .. "" .. "%*"
  end
end

return M
