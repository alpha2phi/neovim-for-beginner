local M = {}

function M.input()
  vim.ui.input({
    prompt = "Enter a value: ",
    default = "default value",
    completion = "file",
    highlight = function(input)
      --print(input)
      if str:len(input) > 3 then
	      return { { 0, 3, "DiffText" } }
      else
      return {{}}
      end
    end,
  }, function(input)
    if input then
      print("You entered " .. input)
    else
      print "You cancelled"
    end
  end)

  -- Parameters: ~
  --     {opts}        (table) Additional options. See |input()|
  --                   • prompt (string|nil) Text of the prompt.
  --                     Defaults to `Input:`.
  --                   • default (string|nil) Default reply to the
  --                     input
  --                   • completion (string|nil) Specifies type of
  --                     completion supported for input. Supported
  --                     types are the same that can be supplied to
  --                     a user-defined command using the
  --                     "-complete=" argument. See
  --                     |:command-completion|
  --                   • highlight (function) Function that will be
  --                     used for highlighting user inputs.
  --     {on_confirm}  (function) ((input|nil) -> ()) Called once
  --                   the user confirms or abort the input.
  --                   `input` is what the user typed. `nil` if the
  --                   user aborted the dialog.
end

function M.select()
  vim.ui.select({ "tabs", "spaces" }, {
    prompt = "Select tabs or spaces:",
    format_item = function(item)
      return "I'd like to choose " .. item
    end,
  }, function(choice)
    if choice == "spaces" then
      vim.o.expandtab = true
    else
      vim.o.expandtab = false
    end
  end)

  -- Parameters: ~
  --     {items}      (table) Arbitrary items
  --     {opts}       (table) Additional options
  --                  • prompt (string|nil) Text of the prompt.
  --                    Defaults to `Select one of:`
  --                  • format_item (function item -> text)
  --                    Function to format an individual item from
  --                    `items`. Defaults to `tostring`.
  --                  • kind (string|nil) Arbitrary hint string
  --                    indicating the item shape. Plugins
  --                    reimplementing `vim.ui.select` may wish to
  --                    use this to infer the structure or
  --                    semantics of `items`, or the context in
  --                    which select() was called.
  --     {on_choice}  (function) ((item|nil, idx|nil) -> ()) Called
  --                  once the user made a choice. `idx` is the
  --                  1-based index of `item` within `items`. `nil`
  --                  if the user aborted the dialog.
end

-- M.select()
M.input()

return M
