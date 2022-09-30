local M = {}

function M.setup()
  require("harpoon").setup {
    global_settings = {
      save_on_toggle = true,
      enter_on_sendcmd = true,
    },
  }
end

return M
