local M = {}

function M.setup()
  require("auto-session").setup {
    log_level = "info",
    auto_save_enabled = true,
    auto_restore_enabled = false,
    auto_session_enable_last_session = false,
  }

  require("session-lens").setup {}
  require("telescope").load_extension "session-lens"
end

return M
