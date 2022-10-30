local M = {}

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
  -- Test config
  vim.g["test#strategy"] = "neovim"
  vim.g["test#neovim#term_position"] = "belowright"
  vim.g["test#neovim#preserve_screen"] = 1

  -- Python
  vim.g["test#python#runner"] = "pyunit" -- pytest

  -- Javascript
  vim.g["test#javascript#reactscripts#options"] = "--watchAll=false"
  vim.g["test#javascript#runner"] = "jest"
  vim.g["test#javascript#cypress#executable"] = "npx cypress run-ct"

  -- csharp
  vim.g["test#csharp#runner"] = "dotnettest"
end

return M
