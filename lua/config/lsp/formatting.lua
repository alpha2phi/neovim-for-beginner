local M = {}

local utils = require "utils"

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
    vim.lsp.buf.formatting_sync(nil, 2000)
  end
end

function M.setup(client, buf)
  local ft = vim.api.nvim_buf_get_option(buf, "filetype")
  local nls = require "config.lsp.null-ls"

  local enable = false
  if nls.has_formatter(ft) then
    enable = client.name == "null-ls"
  else
    enable = not (client.name == "null-ls")
  end

  client.resolved_capabilities.document_formatting = enable
  if client.resolved_capabilities.document_formatting then
    utils.info("defining")
    vim.cmd [[
      augroup LspFormat
        autocmd! * <Buffer>
        autocmd BufWritePre <Buffer> lua require("config.lsp.formatting").format()
      augroup END
    ]]
  end
end

return M
