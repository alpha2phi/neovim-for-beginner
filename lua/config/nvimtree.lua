local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = false,
    hijack_netrw = true,
    view = {
      number = false,
      relativenumber = false,
    },
    filters = {
      custom = { ".git" },
    },
    update_cwd = true,
    update_focused_file = {
      enable = true,
      update_cwd = true,
    },
  }

  vim.g.nvim_tree_respect_buf_cwd = 1
end

return M
