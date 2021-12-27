local keymap = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }
local expr_options = { noremap = true, expr = true, silent = true }

-- Center search results
keymap("n", "n", "nzz", default_options)
keymap("n", "N", "Nzz", default_options)

-- Visual line wraps
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_options)
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_options)

-- Be
keymap("v", "<", "<gv", default_options)
keymap("v", ">", ">gv", default_options)

-- paste over currently selected text without yanking it
keymap("v", "p", '"_dP', default_options)
