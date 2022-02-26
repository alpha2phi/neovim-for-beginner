local M = {}

local whichkey = require "which-key"

local keymap = vim.api.nvim_set_keymap
local buf_keymap = vim.api.nvim_buf_set_keymap

local function keymappings(client, bufnr)
  local opts = { noremap = true, silent = true }

  -- Key mappings
  buf_keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  -- vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

  keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap("n", "[e", "<cmd>lua vim.diagnostic.goto_prev({severity = vim.diagnostic.severity.ERROR})<CR>", opts)
  keymap("n", "]e", "<cmd>lua vim.diagnostic.goto_next({severity = vim.diagnostic.severity.ERROR})<CR>", opts)

  -- Whichkey
  local keymap_l = {
    l = {
      name = "LSP",
      R = { "<cmd>Trouble lsp_references<cr>", "Trouble References" },
      a = { "<cmd>Telescope lsp_code_actions<CR>", "Code Action" },
      d = { "<cmd>Telescope diagnostics<CR>", "Diagnostics" },
      f = { "<cmd>Lspsaga lsp_finder<CR>", "Finder" },
      i = { "<cmd>LspInfo<CR>", "Lsp Info" },
      n = { "<cmd>Lspsaga rename<CR>", "Rename" },
      r = { "<cmd>Telescope lsp_references<CR>", "References" },
      s = { "<cmd>Telescope lsp_document_symbols<CR>", "Document Symbols" },
      t = { "<cmd>TroubleToggle<CR>", "Trouble" },
      L = { "<cmd>lua vim.lsp.codelens.refresh()<CR>", "Refresh CodeLens" },
      l = { "<cmd>lua vim.lsp.codelens.run()<CR>", "Run CodeLens" },
      h = { "<cmd>lua vim.diagnostic.hide()<CR>", "Hide Diagnostics" },
    },
  }
  if client.resolved_capabilities.document_formatting then
    keymap_l.l.F = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format Document" }
  end

  local keymap_g = {
    name = "Goto",
    d = { "<Cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
    D = { "<Cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
    s = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    I = { "<cmd>Telescope lsp_implementations<CR>", "Goto Implementation" },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Goto Type Definition" },
  }
  whichkey.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
  whichkey.register(keymap_g, { buffer = bufnr, prefix = "g" })
end

local function signature_help(client, bufnr)
  local trigger_chars = client.resolved_capabilities.signature_help_trigger_characters
  for _, char in ipairs(trigger_chars) do
    vim.keymap.set("i", char, function()
      vim.defer_fn(function()
        pcall(vim.lsp.buf.signature_help)
      end, 0)
      return char
    end, {
      buffer = bufnr,
      noremap = true,
      silent = true,
      expr = true,
    })
  end
end

function M.setup(client, bufnr)
  keymappings(client, bufnr)
  -- signature_help(client, bufnr) -- use cmp-nvim-lsp-signature-help
end

return M
