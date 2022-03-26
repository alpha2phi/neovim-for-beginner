local M = {}

function M.setup()
  vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

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
