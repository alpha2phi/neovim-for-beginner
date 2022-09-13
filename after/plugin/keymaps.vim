" Search help for WORD under cursor
map <F1> <ESC>:exec "help ".expand("<cWORD>")<CR>

" nvim-treehopper
omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>
xnoremap <silent> m :lua require('tsht').nodes()<CR>
