local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- Git client
local git_tui = "lazygit"
-- local git_tui = "gitui"

-- Docker
local docker_lazydocker = "lazydocker"

-- Docker ctop
local docker_ctop = "ctop"

-- Docker dockly
local docker_dockly = "dockly"

-- Committizen
local git_cz = "git cz"

-- Tokei
local tokei = "tokei"

-- Bottom
local bottom = "btm"

-- navi
local navi = "navi fn welcome"

local git_client = Terminal:new {
  cmd = git_tui,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

local docker_client = Terminal:new {
  cmd = docker_lazydocker,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

local docker_ctop_client = Terminal:new {
  cmd = docker_ctop,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

local docker_dockly_client = Terminal:new {
  cmd = docker_dockly,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

local git_commit = Terminal:new {
  cmd = git_cz,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
}

local project_info = Terminal:new {
  cmd = tokei,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  close_on_exit = false,
}

local system_info = Terminal:new {
  cmd = bottom,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  close_on_exit = true,
}

local interactive_cheatsheet = Terminal:new {
  cmd = navi,
  dir = "git_dir",
  hidden = true,
  direction = "float",
  float_opts = {
    border = "double",
  },
  close_on_exit = false,
}

function M.git_client_toggle()
  git_client:toggle()
end

function M.docker_client_toggle()
  docker_client:toggle()
end

function M.docker_ctop_toggle()
  docker_ctop_client:toggle()
end

function M.docker_dockly_toggle()
  docker_dockly_client:toggle()
end

function M.git_commit_toggle()
  git_commit:toggle()
end

function M.project_info_toggle()
  project_info:toggle()
end

function M.system_info_toggle()
  system_info:toggle()
end

function M.interactive_cheatsheet_toggle()
  interactive_cheatsheet:toggle()
end

-- Open a terminal
local function default_on_open(term)
  vim.cmd "stopinsert"
  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
end

function M.open_term(cmd, opts)
  opts = opts or {}
  opts.size = opts.size or vim.o.columns * 0.5
  opts.direction = opts.direction or "vertical"
  opts.on_open = opts.on_open or default_on_open
  opts.on_exit = opts.on_exit or nil

  local new_term = Terminal:new {
    cmd = cmd,
    dir = "git_dir",
    auto_scroll = false,
    close_on_exit = false,
    start_in_insert = false,
    on_open = opts.on_open,
    on_exit = opts.on_exit,
  }
  new_term:open(opts.size, opts.direction)
end

------------------ Cheatsheet ----------------------------
local lang = ""
local file_type = ""

local function cht_on_open(term)
  vim.cmd "stopinsert"
  vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
  vim.api.nvim_buf_set_name(term.bufnr, "cheatsheet-" .. term.bufnr)
  vim.api.nvim_buf_set_option(term.bufnr, "filetype", "cheat")
  vim.api.nvim_buf_set_option(term.bufnr, "syntax", lang)
end

local function cht_on_exit(_)
  vim.cmd [[normal gg]]
end

function M.cht()
  local buf = vim.api.nvim_get_current_buf()
  lang = ""
  file_type = vim.api.nvim_buf_get_option(buf, "filetype")
  vim.ui.input({ prompt = "cht.sh input: ", default = file_type .. " " }, function(input)
    local cmd = ""
    if input == "" or not input then
      return
    elseif input == "h" then
      cmd = ""
    else
      local search = ""
      local delimiter = " "
      for w in (input .. delimiter):gmatch("(.-)" .. delimiter) do
        if lang == "" then
          lang = w
        else
          if search == "" then
            search = w
          else
            search = search .. "+" .. w
          end
        end
      end
      cmd = lang
      if search ~= "" then
        cmd = cmd .. "/" .. search
      end
    end
    cmd = "curl cht.sh/" .. cmd
    M.open_term(cmd, { on_open = cht_on_open, on_exit = cht_on_exit })
  end)
end

function M.so()
  local buf = vim.api.nvim_get_current_buf()
  lang = ""
  file_type = vim.api.nvim_buf_get_option(buf, "filetype")
  vim.ui.input({ prompt = "so input: ", default = file_type .. " " }, function(input)
    local cmd = ""
    if input == "" or not input then
      return
    elseif input == "h" then
      cmd = "-h"
    else
      cmd = input
    end
    cmd = "so " .. cmd
    M.open_term(cmd, { direction = "float" })
  end)
end

function M.rust_book()
  vim.ui.input({ prompt = "rust book: ", default = "" }, function(input)
    if not input then
      return
    end
    local cmd = "thebook " .. input
    M.open_term(cmd, { direction = "tab" })
  end)
end

return M
