local M = {}

function M.setup()
  require("bufferline").setup {
    options = {
      mode = "buffers",
      numbers = "buffer_id",
      diagnostics = "nvim_lsp",
      separator_style = "slant" or "padded_slant",
      show_tab_indicators = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
    },
  }
end

return M
