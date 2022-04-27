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
      -- custom_filter = function(buf_number, buf_numbers)
      --   if not not vim.api.nvim_buf_get_name(buf_number):find(vim.fn.getcwd(), 0, true) then
      --     return true
      --   end
      -- end,
    },
  }
end

return M
