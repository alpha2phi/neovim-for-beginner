local M = {}

function M.setup()
  local actions = require "telescope.actions"

  require("telescope").setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
    defaults = {
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
        },
      },
    },
  }

  require("telescope").load_extension "fzf"
  require("telescope").load_extension "project"
  require("telescope").load_extension "repo"
end

return M
