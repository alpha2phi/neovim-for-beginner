local M = {}

-- Find a file either using git files or search the filesystem.
function M.find_files()
  if PLUGINS.telescope.enabled then
    local opts = {}
    local telescope = require "telescope.builtin"

    local ok = pcall(telescope.git_files, opts)
    if not ok then
      telescope.find_files(opts)
    end
  else
    local fzf = require "fzf-lua"
    if vim.fn.system "git rev-parse --is-inside-work-tree" == true then
      fzf.git_files()
    else
      fzf.files()
    end
  end
end

-- Custom find buffers function.
function M.find_buffers()
  local results = {}
  local buffers = vim.api.nvim_list_bufs()

  for _, buffer in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buffer) then
      local filename = vim.api.nvim_buf_get_name(buffer)
      table.insert(results, filename)
    end
  end

  vim.ui.select(results, { prompt = "Find buffer:" }, function(selected)
    if selected then
      vim.api.nvim_command("buffer " .. selected)
    end
  end)
end

-- Find dotfiles
function M.find_dotfiles()
  require("telescope.builtin").find_files {
    prompt_title = "<Dotfiles>",
    cwd = "$HOME/workspace/alpha2phi/dotfiles/",
  }
end

return M
