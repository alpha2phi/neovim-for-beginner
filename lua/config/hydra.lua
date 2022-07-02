local M = {}

local function move_split_size()
  local Hydra = require "hydra"
  Hydra {
    hint = [[
       ^^^^^^     Move     ^^^^^^   ^^     Split         ^^^^    Size
       ^^^^^^--------------^^^^^^   ^^---------------    ^^^^-------------
       ^ ^ _k_ ^ ^   ^ ^ _K_ ^ ^    _s_: horizontally    _+_ _-_: height
       _h_ ^ ^ _l_   _H_ ^ ^ _L_    _v_: vertically      _>_ _<_: width
       ^ ^ _j_ ^ ^   ^ ^ _J_ ^ ^    _q_: close           ^ _=_ ^: equalize
       focus^^^^^^   window^^^^^^
       ^ ^ ^ ^ ^ ^   ^ ^ ^ ^ ^ ^    ^ ^ ^    _<Esc>_
    ]],
    config = {
      -- timeout = 4000,
      invoke_on_body = false,
      hint = {
        border = "rounded",
        -- position = 'bottom',
      },
    },
    mode = "n",
    body = "<C-w>",
    heads = {
      -- Move focus
      { "h", "<C-w>h" },
      { "j", "<C-w>j" },
      { "k", "<C-w>k" },
      { "l", "<C-w>l" },
      -- Move window
      { "H", "<Cmd>WinShift left<CR>" },
      { "J", "<Cmd>WinShift down<CR>" },
      { "K", "<Cmd>WinShift up<CR>" },
      { "L", "<Cmd>WinShift right<CR>" },
      -- Split
      { "s", "<C-w>s" },
      { "v", "<C-w>v" },
      { "q", "<Cmd>try | close | catch | endtry<CR>", { desc = "close window" } },
      -- Size
      { "+", "<C-w>+" },
      { "-", "<C-w>-" },
      { ">", "2<C-w>>", { desc = "increase width" } },
      { "<", "2<C-w><", { desc = "decrease width" } },
      { "=", "<C-w>=", { desc = "equalize" } },
      --
      { "<Esc>", nil, { exit = true } },
    },
  }
end

local function cmd(command)
  return table.concat { "<Cmd>", command, "<CR>" }
end

local function telescope_menu()
  local Hydra = require "hydra"

  local hint = [[
                 _f_: files       _m_: marks
   🭇🬭🬭🬭🬭🬭🬭🬭🬭🬼    _o_: old files   _g_: live grep
  🭉🭁🭠🭘    🭣🭕🭌🬾   _p_: projects    _/_: search in file
  🭅█ ▁     █🭐
  ██🬿      🭊██   _h_: vim help    _c_: execute command
 🭋█🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█🭀  _k_: keymap      _;_: commands history
 🭤🭒🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹🭝🭙  _r_: registers   _?_: search history

                 _<Enter>_: Telescope           _<Esc>_ 
]]

  Hydra {
    name = "Telescope",
    hint = hint,
    config = {
      color = "teal",
      invoke_on_body = true,
      hint = {
        position = "middle",
        border = "rounded",
      },
    },
    mode = "n",
    body = "<LocalLeader>f",
    heads = {
      { "f", cmd "Telescope find_files" },
      { "g", cmd "Telescope live_grep" },
      { "h", cmd "Telescope help_tags", { desc = "Vim help" } },
      { "o", cmd "Telescope oldfiles", { desc = "Recently opened files" } },
      { "m", cmd "MarksListBuf", { desc = "Marks" } },
      { "k", cmd "Telescope keymaps" },
      { "r", cmd "Telescope registers" },
      { "p", cmd "Telescope projects", { desc = "Projects" } },
      { "/", cmd "Telescope current_buffer_fuzzy_find", { desc = "Search in file" } },
      { "?", cmd "Telescope search_history", { desc = "Search history" } },
      { ";", cmd "Telescope command_history", { desc = "Command-line history" } },
      { "c", cmd "Telescope commands", { desc = "Execute command" } },
      { "<Enter>", cmd "Telescope", { exit = true, desc = "List all pickers" } },
      { "<Esc>", nil, { exit = true, nowait = true } },
    },
  }
end

function M.setup()
  move_split_size()
  telescope_menu()
end

return M
