local M = {}

local function all_registers()
  return {
    "*",
    "+",
    '"',
    "-",
    "/",
    "_",
    "=",
    "#",
    "%",
    ".",
    "0",
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "a",
    "b",
    "c",
    "d",
    "e",
    "f",
    "g",
    "h",
    "i",
    "j",
    "k",
    "l",
    "m",
    "n",
    "o",
    "p",
    "q",
    "r",
    "s",
    "t",
    "u",
    "v",
    "w",
    "x",
    "y",
    "z",
    ":",
  }
end

function M.create_or_edit(opts)
  opts = opts or {}

  vim.ui.select(all_registers(), {
    prompt = "Select a register",
    format_item = function(reg)
      return reg .. "\t\t\t" .. vim.fn.getreg(reg, 1)
    end,
  }, function(reg)
    if reg then
      vim.ui.input({ prompt = "Edit register " .. reg, default = vim.fn.getreg(reg, 1) }, function(input)
        if input then
          vim.fn.setreg(reg, input)
        end
      end)
    end
  end)
end

M.create_or_edit()

return M
