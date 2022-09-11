local M = {}

local lang = ""
local file_type = ""

function M.cht_input()
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
    M.cht_cmd(cmd)
  end)
end

function M.so_input()
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
    M.so_cmd(cmd)
  end)
end

local function open_split()
  vim.api.nvim_exec("vnew", true)
  vim.api.nvim_exec("terminal", true)
  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_name(buf, "cheatsheet-" .. buf)
  vim.api.nvim_buf_set_option(buf, "filetype", "cheat")
  vim.api.nvim_buf_set_option(buf, "syntax", lang)
end

function M.cht_cmd(cmd)
  open_split()
  local chan_id = vim.b.terminal_job_id
  local cht_cmd = "curl cht.sh/" .. cmd
  vim.api.nvim_chan_send(chan_id, cht_cmd .. "\r\n")
  vim.cmd [[stopinsert]]
end

function M.so_cmd(cmd)
  open_split()
  local chan_id = vim.b.terminal_job_id
  local so_cmd = "so " .. cmd
  vim.api.nvim_chan_send(chan_id, so_cmd .. "\n")
end

return M
