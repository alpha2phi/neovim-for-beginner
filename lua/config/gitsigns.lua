local M = {}

function M.setup()
  require("gitsigns").setup {
    signs = {
      add = { hl = "GitSignsAdd", text = "▍", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
      change = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
      delete = {
        hl = "GitSignsDelete",
        text = "▸",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      topdelete = {
        hl = "GitSignsDelete",
        text = "▾",
        numhl = "GitSignsDeleteNr",
        linehl = "GitSignsDeleteLn",
      },
      changedelete = {
        hl = "GitSignsChange",
        text = "▍",
        numhl = "GitSignsChangeNr",
        linehl = "GitSignsChangeLn",
      },
    },
    -- update_debounce = 100,
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, opts)
        opts = opts or {}
        opts.buffer = bufnr
        vim.keymap.set(mode, l, r, opts)
      end

      -- Navigation
      map("n", "]c", function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          gs.next_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      map("n", "[c", function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          gs.prev_hunk()
        end)
        return "<Ignore>"
      end, { expr = true })

      -- Actions
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", { desc = "Stage Hunk" })
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", { desc = "Reset Hunk" })
      map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage Buffer" })
      map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo Stage Hunk" })
      map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset Buffer" })
      map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview Hunk" })
      map("n", "<leader>ghb", function()
        gs.blame_line { full = true }
      end, { desc = "Blame Line" })
      map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "Toggle Line Blame" })
      map("n", "<leader>ghd", gs.diffthis, { desc = "Diff This" })
      map("n", "<leader>ghD", function()
        gs.diffthis "~"
      end, { desc = "Diff This ~" })
      map("n", "<leader>gtd", gs.toggle_deleted, { desc = "Toggle Delete" })

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select Hunk" })
    end,
  }
end

return M
