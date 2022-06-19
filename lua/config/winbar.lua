local M = {}

local colors = require "config.colors"

vim.api.nvim_set_hl(0, "WinBarSeparator", { fg = colors.grey })
vim.api.nvim_set_hl(0, "WinBarContent", { fg = colors.green, bg = colors.grey })

local winbar_filetype_exclude = {
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

function M.statusline()
  if vim.tbl_contains(winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return ""
  end

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

return M
