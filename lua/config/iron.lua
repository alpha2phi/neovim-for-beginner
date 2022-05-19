local iron = require "iron.core"

iron.setup {
  config = {
    should_map_plug = false,
    scratch_repl = true,
    repl_definition = {
      sh = {
        command = { "zsh" },
      },
    },
  },
  keymaps = {
    send_motion = "<space>sc",
    visual_send = "<space>sc",
    send_line = "<space>sl",
    repeat_cmd = "<space>s.",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
}
