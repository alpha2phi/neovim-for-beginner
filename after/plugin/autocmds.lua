if vim.fn.has "nvim-0.7" then
  local api = vim.api

  -- Highlight on yank
  local yankGrp = api.nvim_create_augroup("YankHighlight", { clear = true })
  api.nvim_create_autocmd("TextYankPost", {
    command = "silent! lua vim.highlight.on_yank()",
    group = yankGrp,
  })

  -- show cursor line only in active window
  local cursorGrp = api.nvim_create_augroup("CursorLine", { clear = true })
  api.nvim_create_autocmd(
    { "InsertLeave", "WinEnter" },
    { pattern = "*", command = "set cursorline", group = cursorGrp }
  )
  api.nvim_create_autocmd(
    { "InsertEnter", "WinLeave" },
    { pattern = "*", command = "set nocursorline", group = cursorGrp }
  )

  -- go to last loc when opening a buffer
  api.nvim_create_autocmd(
    "BufReadPost",
    { command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]] }
  )

  -- Check if we need to reload the file when it changed
  api.nvim_create_autocmd("FocusGained", { command = [[:checktime]] })

  -- windows to close with "q"
  api.nvim_create_autocmd(
    "FileType",
    { pattern = { "help", "startuptime", "qf", "lspinfo" }, command = [[nnoremap <buffer><silent> q :close<CR>]] }
  )
  api.nvim_create_autocmd("FileType", { pattern = "man", command = [[nnoremap <buffer><silent> q :quit<CR>]] })

  -- don't auto comment new line
  api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })
else
  local cmd = vim.cmd

  -- Highlight on yank
  cmd [[
    augroup YankHighlight
      autocmd!
      autocmd TextYankPost * silent! lua vim.highlight.on_yank()
    augroup end
  ]]

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
