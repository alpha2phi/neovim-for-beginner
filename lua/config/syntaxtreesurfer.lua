local M = {}

local keymap = vim.keymap.set

function M.setup()
  -- Normal Mode Swapping
  keymap("n", "vu", '<cmd>lua require("syntax-tree-surfer").move("n", true)<cr>', { noremap = true, silent = true })
  keymap("n", "vd", '<cmd>lua require("syntax-tree-surfer").move("n", false)<cr>', { noremap = true, silent = true })
  -- .select() will show you what you will be swapping with .move(), you'll get used to .select() and .move() behavior quite soon!
  keymap("n", "vx", '<cmd>lua require("syntax-tree-surfer").select()<cr>', { noremap = true, silent = true })
  -- .select_current_node() will select the current node at your cursor
  keymap(
    "n",
    "vn",
    '<cmd>lua require("syntax-tree-surfer").select_current_node()<cr>',
    { noremap = true, silent = true }
  )
  keymap(
    "n",
    "vo",
    '<cmd>lua require("syntax-tree-surfer").go_to_top_node_and_execute_commands(false, { "normal! O", "normal! O", "startinsert" })<cr>',
    { noremap = true, silent = true }
  )

  -- NAVIGATION -  Only change the keymap to your liking. I would not recommend changing anything about the .surf() parameters!
  -- keymap(
  --   "x",
  --   "J",
  --   '<cmd>lua require("syntax-tree-surfer").surf("next", "visual")<cr>',
  --   { noremap = true, silent = true }
  -- )
  -- keymap(
  --   "x",
  --   "K",
  --   '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual")<cr>',
  --   { noremap = true, silent = true }
  -- )
  keymap(
    "x",
    "H",
    '<cmd>lua require("syntax-tree-surfer").surf("parent", "visual")<cr>',
    { noremap = true, silent = true }
  )
  keymap(
    "x",
    "L",
    '<cmd>lua require("syntax-tree-surfer").surf("child", "visual")<cr>',
    { noremap = true, silent = true }
  )

  -- SWAPPING WITH VISUAL SELECTION - Only change the keymap to your liking. Don't change the .surf() parameters!
  keymap(
    "x",
    "<C-j>",
    '<cmd>lua require("syntax-tree-surfer").surf("next", "visual", true)<cr>',
    { noremap = true, silent = true }
  )
  keymap(
    "x",
    "<C-k>",
    '<cmd>lua require("syntax-tree-surfer").surf("prev", "visual", true)<cr>',
    { noremap = true, silent = true }
  )
end

return M
