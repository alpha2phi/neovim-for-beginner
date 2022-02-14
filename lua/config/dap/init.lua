local M = {}

local debuggers = {
  python = {},
}

local function configure_exts()
  -- DAP virtual text
  require("nvim-dap-virtual-text").setup()

  -- DAP UI
  require("dapui").setup()
end

function M.setup()
  -- Configure extensions
  configure_exts()

  -- Install debuggers
  require("config.dap.installer").setup(debuggers)
end
return M
