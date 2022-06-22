local M = {}

vim.api.nvim_set_hl(0, "InputHighlight", { fg = "#ffffff", ctermfg = 255, bg = "#00ff00", ctermbg = 14 })
function M.input()
  vim.ui.input({
    prompt = "Enter a value: ",
    default = "default value",
    completion = "file",
    highlight = function(input)
      if string.len(input) > 8 then
        return { { 0, 8, "InputHighlight" } }
      else
        return {}
      end
    end,
  }, function(input)
    if input then
      print("You entered " .. input)
    else
      print "You cancelled"
    end
  end)
end

function M.select()
  vim.ui.select({ "Australia", "Belarus", "Canada", "Denmark", "Egypt", "Fiji" }, {
    prompt = "Select a country",
    format_item = function(item)
      return "I like to visit " .. item
    end,
  }, function(country, idx)
    if country then
      print("You selected " .. country .. " at index " .. idx)
    else
      print "You cancelled"
    end
  end)
end

-- vim.ui.select = require("guihua.gui").select
-- vim.ui.input = require("guihua.gui").input

M.select()
-- M.input()

return M