local M = {}

function M.setup(servers, options)
  local lspconfig = require "lspconfig"
  local icons = require "config.icons"

  -- nvim-lsp-installer must be set up before nvim-lspconfig
  require("nvim-lsp-installer").setup {
    ensure_installed = vim.tbl_keys(servers),
    automatic_installation = false,
    ui = {
      icons = {
        server_installed = icons.server_installed,
        server_pending = icons.server_pending,
        server_uninstalled = icons.server_uninstalled,
      },
    },
  }

  -- Set up LSP servers
  for server_name, _ in pairs(servers) do
    local opts = vim.tbl_deep_extend("force", options, servers[server_name] or {})

    if server_name == "sumneko_lua" then
      opts = require("lua-dev").setup { lspconfig = opts }
    end

    if server_name == "jdtls" then
      print "jdtls is handled by nvim-jdtls"
    elseif server_name == "rust_analyzer" then
      -- DAP settings - https://github.com/simrat39/rust-tools.nvim#a-better-debugging-experience
      local extension_path = vim.fn.glob(vim.env.HOME .. "/.vscode/extensions/vadimcn.vscode-lldb-*")
      local codelldb_path = extension_path .. "adapter/codelldb"
      local liblldb_path = extension_path .. "lldb/lib/liblldb.so"
      require("rust-tools").setup {
        server = opts,
        dap = {
          adapter = require("rust-tools.dap").get_codelldb_adapter(codelldb_path, liblldb_path),
        },
      }
    elseif server_name == "tsserver" then
      require("typescript").setup {
        disable_commands = false,
        debug = false,
        server = opts,
      }
    else
      lspconfig[server_name].setup(opts)
    end
  end
end

return M
