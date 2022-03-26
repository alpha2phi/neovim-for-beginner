local M = {}

-- Color table for highlights
local colors = {
  bg = "#202328",
  fg = "#bbc2cf",
  yellow = "#ECBE7B",
  cyan = "#008080",
  darkblue = "#081633",
  green = "#98be65",
  orange = "#FF8800",
  violet = "#a9a1e1",
  magenta = "#c678dd",
  blue = "#51afef",
  red = "#ec5f67",
}

local function separator()
  return "%="
end

local function lsp_client(msg)
  msg = msg or ""
  local buf_clients = vim.lsp.buf_get_clients()
  if next(buf_clients) == nil then
    if type(msg) == "boolean" or #msg == 0 then
      return ""
    end
    return msg
  end

  local buf_ft = vim.bo.filetype
  local buf_client_names = {}

  -- add client
  for _, client in pairs(buf_clients) do
    if client.name ~= "null-ls" then
      table.insert(buf_client_names, client.name)
    end
  end

  -- add formatter
  local formatters = require "config.lsp.null-ls.formatters"
  local supported_formatters = formatters.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_formatters)

  -- add linter
  local linters = require "config.lsp.null-ls.linters"
  local supported_linters = linters.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_linters)

  -- add hover
  local hovers = require "config.lsp.null-ls.hovers"
  local supported_hovers = hovers.list_registered(buf_ft)
  vim.list_extend(buf_client_names, supported_hovers)

  return "[" .. table.concat(buf_client_names, ", ") .. "]"
end

-------- use fidget.nvim ------
-- local function lsp_progress(_, is_active)
--   if not is_active then
--     return
--   end
--   local messages = vim.lsp.util.get_progress_messages()
--   if #messages == 0 then
--     return ""
--   end
--   local status = {}
--   for _, msg in pairs(messages) do
--     local title = ""
--     if msg.title then
--       title = msg.title
--     end
--     table.insert(status, (msg.percentage or 0) .. "%% " .. title)
--   end
--   local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
--   local ms = vim.loop.hrtime() / 1000000
--   local frame = math.floor(ms / 120) % #spinners
--   return table.concat(status, "  ") .. " " .. spinners[frame + 1]
-- end

function M.setup()
  local gps = require "nvim-gps"

  require("lualine").setup {
    options = {
      icons_enabled = true,
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = " ", right = "" },
      disabled_filetypes = {},
      always_divide_middle = true,
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        "branch",
        "diff",
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
          colored = false,
        },
      },
      lualine_c = {
        { separator },
        { lsp_client, icon = " ", color = { fg = colors.violet, gui = "bold" } },
        -- { lsp_progress },
        {
          gps.get_location,
          cond = gps.is_available,
          color = { fg = colors.green },
        },
      },
      lualine_x = { "filename", "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = {},
  }
end

return M
