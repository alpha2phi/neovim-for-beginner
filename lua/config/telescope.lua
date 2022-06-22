local M = {}

-- Custom actions
local transform_mod = require("telescope.actions.mt").transform_mod
local nvb_actions = transform_mod {
  file_path = function(prompt_bufnr)
    -- Get selected entry and the file full path
    local content = require("telescope.actions.state").get_selected_entry()
    local full_path = content.cwd .. require("plenary.path").path.sep .. content.value

    -- Yank the path to unnamed and clipboard registers
    vim.fn.setreg('"', full_path)
    vim.fn.setreg("+", full_path)

    -- Close the popup
    require("utils").info "File path is yanked "
    require("telescope.actions").close(prompt_bufnr)
  end,
}

-- trouble.nvim
local trouble = require "trouble.providers.telescope"
local icons = require "config.icons"

function M.setup()
  local actions = require "telescope.actions"
  local telescope = require "telescope"

  -- Custom previewer
  local previewers = require "telescope.previewers"
  local Job = require "plenary.job"
  local preview_maker = function(filepath, bufnr, opts)
    filepath = vim.fn.expand(filepath)
    Job
      :new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]

          if mime_type == "text" then
            -- Check file size
            vim.loop.fs_stat(filepath, function(_, stat)
              if not stat then
                return
              end
              if stat.size > 500000 then
                return
              else
                previewers.buffer_previewer_maker(filepath, bufnr, opts)
              end
            end)
          else
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY FILE" })
            end)
          end
        end,
      })
      :sync()
  end

  telescope.setup {
    defaults = {
      prompt_prefix = icons.ui.Telescope .. " ",
      selection_caret = " ",
      -- path_display = { "smart" },
      buffer_previewer_maker = preview_maker,
      mappings = {
        i = {
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<c-z>"] = trouble.open_with_trouble,
        },
      },
      history = {
        path = vim.fn.stdpath "data" .. "/telescope_history.sqlite3",
        limit = 100,
      },
    },
    pickers = {
      find_files = {
        theme = "ivy",
        mappings = {
          n = {
            ["y"] = nvb_actions.file_path,
          },
          i = {
            ["<C-y>"] = nvb_actions.file_path,
          },
        },
        hidden = true,
      },
      git_files = {
        theme = "dropdown",
        mappings = {
          n = {
            ["y"] = nvb_actions.file_path,
          },
          i = {
            ["<C-y>"] = nvb_actions.file_path,
          },
        },
      },
    },
    extensions = {
      arecibo = {
        ["selected_engine"] = "google",
        ["url_open_command"] = "xdg-open",
        ["show_http_headers"] = false,
        ["show_domain_icons"] = false,
      },
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg", "pdf", "mp4", "webm" },
        find_cmd = "fd",
      },
      bookmarks = {
        selected_browser = "brave",
        url_open_command = nil,
        url_open_plugin = "open_browser",
        full_path = true,
        firefox_profile_name = nil,
      },
      project = {
        hidden_files = false,
        theme = "dropdown",
      },
      -- aerial = {
      --   show_nesting = true,
      -- },
    },
  }

  require("neoclip").setup() -- https://github.com/AckslD/nvim-neoclip.lua/issues/5

  telescope.load_extension "fzf"
  telescope.load_extension "project" -- telescope-project.nvim
  telescope.load_extension "repo"
  telescope.load_extension "file_browser"
  -- telescope.load_extension "projects" -- project.nvim
  telescope.load_extension "dap"
  telescope.load_extension "frecency"
  telescope.load_extension "neoclip"
  telescope.load_extension "smart_history"
  telescope.load_extension "arecibo"
  telescope.load_extension "media_files"
  telescope.load_extension "bookmarks"
  telescope.load_extension "aerial"
  telescope.load_extension "gh"
  telescope.load_extension "zoxide"
  telescope.load_extension "cder"
  -- telescope.load_extension "ui-select"
  -- telescope.load_extension "flutter" -- Flutter
end

return M
