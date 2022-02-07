local M = {}

local nls = require "null-ls"
local b = nls.builtins

local with_diagnostics_code = function(builtin)
  return builtin.with {
    diagnostics_format = "#{m} [#{c}]",
  }
end

local with_root_file = function(builtin, file)
  return builtin.with {
    condition = function(utils)
      return utils.root_has_file(file)
    end,
  }
end

local sources = {
  -- formatting
  b.formatting.prettier,
  b.formatting.fish_indent,
  b.formatting.shfmt,
  b.formatting.trim_whitespace.with { filetypes = { "tmux", "teal" } },
  with_root_file(b.formatting.stylua, "stylua.toml"),

  -- diagnostics
  with_root_file(b.diagnostics.selene, "selene.toml"),
  b.diagnostics.write_good,
  b.diagnostics.markdownlint,
  b.diagnostics.teal,
  b.diagnostics.tsc,
  with_diagnostics_code(b.diagnostics.shellcheck),

  -- code actions
  b.code_actions.gitsigns,
  b.code_actions.gitrebase,

  -- hover
  b.hover.dictionary,
}

function M.setup(on_attach)
  nls.setup {
    -- debug = true,
    sources = sources,
    on_attach = on_attach,
  }
end

return M
