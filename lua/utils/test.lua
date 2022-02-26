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

return M
