local lsp_installer_servers = require "nvim-lsp-installer.servers"
local utils = require "utils"

local M = {}

function M.setup(servers, options)
  for server_name, _ in pairs(servers) do
    local server_available, server = lsp_installer_servers.get_server(server_name)

    if server_available then
      server:on_ready(function()
        local opts = vim.tbl_deep_extend("force", options, servers[server.name] or {})

        if server.name == "sumneko_lua" then
          opts = require("lua-dev").setup { lspconfig = opts }
        end

        if server.name == "rust_analyzer" then
          require("rust-tools").setup {
            server = vim.tbl_deep_extend("force", server:get_default_options(), opts),
          }
          server:attach_buffers()
        elseif server.name == "tsserver" then
          require("typescript").setup { server = opts }
        elseif server.name == "jdtls" then
          print "jdtls is handled by nvim-jdtls"
        else
          server:setup(opts)
        end
      end)

      if not server:is_installed() then
        utils.info("Installing " .. server.name, "LSP")
        server:install()
      end
    else
      utils.error(server)
    end
  end
end

return M
