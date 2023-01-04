local M = {}

local utils = require "utils"
local nls_utils = require "config.lsp.null-ls.utils"
local nls_sources = require "null-ls.sources"
local api = vim.api

local method = require("null-ls").methods.FORMATTING

M.autoformat = true

function M.toggle()
  M.autoformat = not M.autoformat
  if M.autoformat then
    utils.info("Enabled format on save", "Formatting")
  else
    utils.warn("Disabled format on save", "Formatting")
  end
end

function M.format()
  if M.autoformat then
    local buf = vim.api.nvim_get_current_buf()
    local ft = vim.bo[buf].filetype
    local have_nls = #require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING") > 0

    local view = vim.fn.winsaveview()
    vim.lsp.buf.format {
      async = true,
      filter = function(client)
        if have_nls then
          return client.name == "null-ls"
        end
        return client.name ~= "null-ls"
      end,
    }
    vim.fn.winrestview(view)
  end
end

function M.setup(client, bufnr)
  local filetype = api.nvim_buf_get_option(bufnr, "filetype")

  local enable = false
  if M.has_formatter(filetype) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  if not enable then
    return
  end

  client.server_capabilities.documentFormattingProvder = enable
  client.server_capabilities.documentRangeFormattingProvider = enable
  if client.server_capabilities.documentFormattingProvider then
    local lsp_format_grp = api.nvim_create_augroup("LspFormat", { clear = true })
    api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        vim.schedule(M.format)
      end,
      group = lsp_format_grp,
      buffer = bufnr,
    })
  end
end

function M.has_formatter(filetype)
  local available = nls_sources.get_available(filetype, method)
  return #available > 0
end

function M.list_registered(filetype)
  local registered_providers = nls_utils.list_registered_providers_names(filetype)
  return registered_providers[method] or {}
end

function M.list_supported(filetype)
  local supported_formatters = nls_sources.get_supported(filetype, "formatting")
  table.sort(supported_formatters)
  return supported_formatters
end

return M
