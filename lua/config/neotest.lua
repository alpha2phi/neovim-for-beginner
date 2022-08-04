local M = {}

function M.setup()
  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
        runner = "unittest",
      },
      require "neotest-jest",
      require "neotest-go",
      require "neotest-plenary",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua" },
      },
      require "neotest-rust",
    },
    -- overseer.nvim
    consumers = {
      overseer = require "neotest.consumers.overseer",
    },
    overseer = {
      enabled = true,
      -- When this is true (the default), it will replace all neotest.run.* commands
      force_default = false,
    },
  }
end

return M
