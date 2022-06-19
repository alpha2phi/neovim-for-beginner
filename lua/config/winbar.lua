local M = {}

local colors = require "config.colors"
local navic = require "nvim-navic"

vim.api.nvim_set_hl(0, "WinBarSeparator", { fg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarContent", { fg = colors.green, bg = colors.grey })

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

function M.get_winbar()
  if excludes() then
    return ""
  end
  if navic.is_available() then
    return "%#WinBarSeparator#"
      .. "%="
      .. ""
      .. "%*"
      .. "%#WinBarContent#"
      .. "%m "
      .. "%t"
      .. "%*"
      .. "%#WinBarContent#"
      .. " "
      .. navic.get_location()
      .. "%*"
      .. "%#WinBarSeparator#"
      .. ""
      .. "%*"
  else
    return "%#WinBarSeparator#"
      .. "%="
      .. ""
      .. "%*"
      .. "%#WinBarContent#"
      .. "%m "
      .. "%t"
      .. "%*"
      .. "%#WinBarSeparator#"
      .. ""
      .. "%*"
  end
end

return M
