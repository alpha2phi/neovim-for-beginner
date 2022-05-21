local M = {}

function M.setup()
  require("jabs").setup {
    position = "center",
    width = 50,
    height = 10,
    border = "rounded",
    preview_position = "top",
    preview = {
      width = 70,
      height = 20,
      border = "rounded",
    },
  }
end

return M
