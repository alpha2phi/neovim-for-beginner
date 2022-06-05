local M = {}

function M.setup()
  vim.g.surround_funk_create_mappings = 0
  local map = vim.keymap.set

  -- operator pending mode: grip surround
  map({ "n", "v" }, "gs", "<Plug>(GripSurroundObject)")
  map({ "o", "x" }, "sF", "<Plug>(SelectWholeFUNCTION)")

  local status, whichkey = pcall(require, "which-key")
  if not status then
    return
  end

  whichkey.register {
    y = {
      name = "+ysf: Yank ",
      s = {
        f = { "<Plug>(YankSurroundingFUNCTION)", "Yank Surrounding Function Call" },
        F = {
          "<Plug>(YankSurroundingFunction)",
          "Yank Surrounding Function Call (Partial)",
        },
      },
    },
    d = {
      name = "+dsf: Function Text Object",
      s = {
        F = { "<Plug>(DeleteSurroundingFunction)", "Delete Surrounding Function" },
        f = { "<Plug>(DeleteSurroundingFUNCTION)", "Delete Surrounding Outer Function" },
      },
    },
    c = {
      name = "+csf: Function Text Object",
      s = {
        F = { "<Plug>(ChangeSurroundingFunction)", "Change Surrounding Function" },
        f = { "<Plug>(ChangeSurroundingFUNCTION)", "Change Outer surrounding Function" },
      },
    },
  }
end

return M
