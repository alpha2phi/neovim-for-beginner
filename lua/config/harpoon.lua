local M = {}

function M.setup()
  require("harpoon").setup {
    global_settings = {
      save_on_toggle = true,
      enter_on_sendcmd = true,
    },
  }
  require("telescope").load_extension "harpoon"
end

return M
