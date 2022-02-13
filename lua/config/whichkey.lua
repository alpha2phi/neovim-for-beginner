local M = {}

local whichkey = require "which-key"

local conf = {
  window = {
    border = "single", -- none, single, double, shadow
    position = "bottom", -- bottom, top
  },
}
whichkey.setup(conf)

local keymap_f = nil -- File search
local keymap_p = nil -- Project search

local opts = {
  mode = "n", -- Normal mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local v_opts = {
  mode = "v", -- Visual mode
  prefix = "<leader>",
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = false, -- use `nowait` when creating keymaps
}

local function normal_keymaps()
  if PLUGINS.telescope.enabled then
    keymap_f = {
      name = "Find",
      f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
      d = { "<cmd>lua require('utils.finder').find_dotfiles()<cr>", "Dotfiles" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      h = { "<cmd>Telescope help_tags<cr>", "Help" },
      o = { "<cmd>Telescope oldfiles<cr>", "Old Files" },
      g = { "<cmd>Telescope live_grep<cr>", "Live Grep" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      r = { "<cmd>Telescope file_browser<cr>", "Browser" },
      w = { "<cmd>Telescope current_buffer_fuzzy_find<cr>", "Current Buffer" },
      e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    }

    keymap_p = {
      name = "Project",
      p = { "<cmd>lua require'telescope'.extensions.project.project{}<cr>", "List" },
      s = { "<cmd>Telescope repo list<cr>", "Search" },
    }
  end

  if PLUGINS.fzf_lua.enabled then
    keymap_f = {
      name = "Find",
      f = { "<cmd>lua require('utils.finder').find_files()<cr>", "Files" },
      b = { "<cmd>FzfLua buffers<cr>", "Buffers" },
      o = { "<cmd>FzfLua oldfiles<cr>", "Old Files" },
      g = { "<cmd>FzfLua live_grep<cr>", "Live Grep" },
      c = { "<cmd>FzfLua commands<cr>", "Commands" },
      e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
    }
  end

  local keymap_normal = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },
    ["t"] = { "<cmd>ToggleTerm<CR>", "Terminal" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close Buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete All Buffers" },
    },

    f = keymap_f,
    p = keymap_p,

    z = {
      name = "System",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      r = { "<cmd>Telescope reloader<cr>", "Reload Module" },
    },

    g = {
      name = "Git",
      s = { "<cmd>Neogit<CR>", "Status" },
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('n', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
    },
  }
  whichkey.register(keymap_normal, opts)
end

local function visual_keymaps()
  local keymap_visual = {
    g = {
      name = "Git",
      y = {
        "<cmd>lua require'gitlinker'.get_buf_range_url('v', {action_callback = require'gitlinker.actions'.open_in_browser})<cr>",
        "Link",
      },
    },
  }

  whichkey.register(keymap_visual, v_opts)
end

function M.setup()
  normal_keymaps()
  visual_keymaps()
  -- local ft = vim.api.nvim_buf_get_option(vim.api.nvim_get_current_buf(), "filetype")
end

return M
