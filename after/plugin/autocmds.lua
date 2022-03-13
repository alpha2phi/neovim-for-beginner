local utils = require "utils"

if vim.fn.has "nvim-0.7" then
  -- Use the autocmd APIs
  print "TODO"
else
  local cmd = vim.cmd

  -- show cursor line only in active window
  cmd [[
    autocmd InsertLeave,WinEnter * set cursorline
    autocmd InsertEnter,WinLeave * set nocursorline
  ]]

  -- go to last loc when opening a buffer
  cmd [[
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  ]]

  -- Check if we need to reload the file when it changed
  cmd "au FocusGained * :checktime"

  -- windows to close with "q"
  cmd [[autocmd FileType help,startuptime,qf,lspinfo nnoremap <buffer><silent> q :close<CR>]]
  cmd [[autocmd FileType man nnoremap <buffer><silent> q :quit<CR>]]

  -- don't auto comment new line
  cmd [[autocmd BufEnter * set formatoptions-=cro]]
end
