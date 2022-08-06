local M = {}

local function config_test()
  vim.api.nvim_exec(
    [[
        " Test config
        let test#strategy = "neovim"
        let test#neovim#term_position = "belowright"
        let g:test#preserve_screen = 1

        " Python
        let test#python#runner = 'pyunit'
        " let test#python#runner = 'pytest'

        " Javascript
        let test#javascript#reactscripts#options = "--watchAll=false"
        let g:test#javascript#runner = 'jest'
        let g:test#javascript#cypress#executable = 'npx cypress run-ct'

        " csharp
        let test#csharp#runner = 'dotnettest'
    ]],
    false
  )
end

function M.javascript_runner()
  local runners = { "cypress", "jest" }
  vim.ui.select(runners, { prompt = "Choose Javascript Runner" }, function(selected)
    if selected then
      vim.g["test#javascript#runner"] = selected
      require("utils").info("Test runner changed to " .. selected, "Test Runner")
    end
  end)
end

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
      force_default = true,
    },
  }

  -- vim-test
  config_test()
end

return M
