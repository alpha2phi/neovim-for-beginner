local M = {}

local utils = require "utils"
local nls_utils = require "config.lsp.null-ls.utils"
local nls_sources = require "null-ls.sources"

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
    local view = vim.fn.winsaveview()
    vim.lsp.buf.format {
      async = true,
      filter = function(client)
        return client.name ~= "tsserver"
          and client.name ~= "jsonls"
          and client.name ~= "html"
          and client.name ~= "sumneko_lua"
        -- and client.name ~= "kotlin_language_server"
      end,
    }
    vim.fn.winrestview(view)
  end
end

function M.setup(client, buf)
  local filetype = vim.api.nvim_buf_get_option(buf, "filetype")

  local enable = false
  if M.has_formatter(filetype) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.server_capabilities.documentFormattingProvder = enable
  client.server_capabilities.documentRangeFormattingProvider = enable
  if client.server_capabilities.documentFormattingProvider then
    vim.cmd [[
      augroup LspFormat
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua require("config.lsp.null-ls.formatters").format()
      augroup END
    ]]
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
