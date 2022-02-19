local M = {}

function M.setup()
  vim.api.nvim_exec(
    [[
        let test#strategy = "neovim"
        let test#neovim#term_position = "belowright"
        let g:test#preserve_screen = 1
        let test#python#runner = 'pyunit'
    ]],
    false
  )

  local builders = {
    python = function(cmd)
      local non_modules = { "python", "pipenv", "poetry" }

      local module_index
      if vim.tbl_contains(non_modules, cmd[1]) then
        module_index = 3
      else
        module_index = 1
      end

      local args = vim.list_slice(cmd, module_index + 1)

      return {
        dap = {
          type = "python",
          name = "Ultest Debugger",
          request = "launch",
          module = cmd[module_index],
          args = args,
          justMyCode = false,
        },
      }
    end,
    ["go#richgo"] = function(cmd)
      local args = {}

      for i = 3, #cmd, 1 do
        local arg = cmd[i]
        if vim.startswith(arg, "-") then
          arg = "-test." .. string.sub(arg, 2)
        end
        args[#args + 1] = arg
      end
      print(vim.inspect(args))
      return {
        dap = {
          type = "go",
          request = "launch",
          mode = "test",
          program = "${workspaceFolder}",
          dlvToolPath = vim.fn.exepath "dlv",
          args = args,
        },
        parse_result = function(lines)
          return lines[#lines] == "FAIL" and 1 or 0
        end,
      }
    end,
  }
  require("ultest").setup { builders = builders }
end

return M
