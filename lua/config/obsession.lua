local M = {}

vim.g.session_dir = vim.fn.stdpath "config" .. "/sessions"

function M.setup()
  -- vim.cmd [[command! -nargs=1 MkSession call MkSession(<f-args>)]]
  -- vim.api.nvim_add_user_command("Upper", function(opts)
  --   print(string.upper(opts.args))
  -- end, { nargs = 1 })
end

function M.mkSession()
  print "Creating session..."
end

function M.loadSession()
  print "Loading session..."
end

return M

-- https://stackoverflow.com/questions/1642611/how-to-save-and-restore-multiple-different-sessions-in-vim

-- let g:sessiondir = $HOME . ".vim/sessions"
--
-- command! -nargs=1 MkSession call MkSession(<f-args>)
-- function! MkSession(sessionfile)
--   if !isdirectory(g:sessiondir)
--     call mkdir(g:sessiondir, "p")
--   endif
--   exe 'Obsession' g:sessiondir . '/' . a:sessionfile
-- endfunction
--
-- command! -nargs=1 LoadSession call LoadSession(<f-args>)
-- function! LoadSession(sessionfile)
--
--   let a:sessionpath = g:sessiondir . a:sessionfile
--   if (filereadable(a:sessionpath))
--     exe 'source ' a:sessionpath
--   else
--     echo "No session loaded."
--   endif
-- endfunction
