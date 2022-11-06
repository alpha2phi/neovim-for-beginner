local M = {}

function M.setup()
  require("noice").setup {
    cmdline = {
      enabled = false,
    },
    messages = {
      enabled = true,
    },
    popupmenu = {
      enabled = false,
    },
    notify = {
      enabled = true,
    },
  }
end

return M
