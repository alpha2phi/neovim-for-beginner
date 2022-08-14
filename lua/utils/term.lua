local M = {}

local Terminal = require("toggleterm.terminal").Terminal

-- Git client
local git_tui = "lazygit"
-- local git_tui = "gitui"

-- Committizen
local git_cz = "git cz"

-- Tokei
local tokei = "tokei"

local git_client = Terminal:new {
  cmd = git_tui,
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

function M.git_client_toggle()
  git_client:toggle()
end

function M.git_commit_toggle()
  git_commit:toggle()
end

function M.project_info_toggle()
  project_info:toggle()
end

local lang = ""
local function cht_cmd(cmd)
  local cht_term = Terminal:new {
    size = function(term)
      return vim.o.columns * 0.5
    end,
    cmd = "curl cht.sh/" .. cmd .. " && read -s -n 1",
    dir = "git_dir",
    direction = "vertical",
    close_on_exit = false,
    start_in_insert = false,
    on_open = function(term)
      vim.cmd "stopinsert"
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
      vim.api.nvim_buf_set_name(term.bufnr, "cheatsheet-" .. term.bufnr)
      vim.api.nvim_buf_set_option(term.bufnr, "filetype", "cheat")
      vim.api.nvim_buf_set_option(term.bufnr, "syntax", lang)
    end,
  }
  cht_term:toggle()
end

function M.cht()
  lang = ""
  vim.ui.input({ prompt = "cht.sh input: " }, function(input)
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
    cht_cmd(cmd)
  end)
end

return M
