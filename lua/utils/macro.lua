local M = {}

function M.edit()
  local register = "i"
  local opts = { default = vim.g.edit_macro_last or "" }

  if opts.default == "" then
    opts.prompt = "Create Macro"
  else
    opts.prompt = "Edit Macro"
  end

  vim.ui.input(opts, function(value)
    if value == nil then
      return
    end

    local macro = vim.fn.escape(value, '"')
    vim.cmd(string.format('let @%s="%s"', register, macro))

    vim.g.edit_macro_last = value
  end)
end

return M
