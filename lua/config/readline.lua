local M = {}

function M.setup()
  local readline = require "readline"
  vim.keymap.set("!", "<M-f>", readline.forward_word)
  vim.keymap.set("!", "<M-b>", readline.backward_word)
  vim.keymap.set("!", "<C-a>", readline.beginning_of_line)
  vim.keymap.set("!", "<C-e>", readline.end_of_line)
  vim.keymap.set("!", "<M-d>", readline.kill_word)
  vim.keymap.set("!", "<M-BS>", readline.backward_kill_word)
  vim.keymap.set("!", "<C-w>", readline.unix_word_rubout)
  vim.keymap.set("!", "<C-k>", readline.kill_line)
  vim.keymap.set("!", "<C-u>", readline.backward_kill_line)
end

return M
