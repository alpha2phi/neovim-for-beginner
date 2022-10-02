-- local api = vim.api
local g = vim.g
local opt = vim.opt
-- local cmd = vim.cmd

-- Remap leader and local leader to <Space>
-- api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.keymap.set("", "<Space>", "<Nop>", { noremap = true, silent = true })
g.mapleader = " "
g.maplocalleader = ","
g.vimsyn_embed = "lPr" -- Syntax embedding for Lua, Python and Ruby

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.timeoutlen = 300 --	Time in milliseconds to wait for a mapped sequence to complete.
opt.showmode = false -- Do not need to show the mode. We use the statusline instead.
opt.scrolloff = 8 -- Lines of context
-- opt.scrolloff = 999 -- Lines of context
-- opt.sidescrolloff = 999
opt.joinspaces = false -- No double spaces with join after a dot
opt.sessionoptions = "buffers,curdir,help,tabpages,winsize,winpos,terminal"
opt.smartindent = true --Smart indent
opt.expandtab = true
opt.smarttab = true
opt.textwidth = 0
opt.autoindent = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.softtabstop = 2
opt.splitbelow = true
opt.splitright = true
opt.laststatus = 3 -- Global statusline
opt.cmdheight = 0
opt.scrollback = 100000

-- Change to use lualine.nvim
-- opt.winbar = "%{%v:lua.require'config.winbar'.get_winbar()%}"

-- go to previous/next line with h,l,left arrow and right arrow when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable nvim intro
opt.shortmess:append "sI"

-- Better search
opt.path:remove "/usr/include"
opt.path:append "**"
-- vim.cmd [[set path=.,,,$PWD/**]] -- Set the path directly

opt.wildignorecase = true
opt.wildignore:append "**/node_modules/*"
opt.wildignore:append "**/.git/*"

-- Better Netrw, alternatively just use vinegar.vim
-- g.netrw_banner = 0 -- Hide banner
-- g.netrw_browse_split = 4 -- Open in previous window
-- g.netrw_altv = 1 -- Open with right splitting
-- g.netrw_liststyle = 3 -- Tree-style view
-- g.netrw_list_hide = (vim.fn["netrw_gitignore#Hide"]()) .. [[,\(^\|\s\s\)\zs\.\S\+]] -- use .gitignore

-- Treesitter based folding
opt.foldlevel = 20
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"

-- opt.foldcolumn = "1"
-- opt.foldlevel = 99
-- opt.foldlevelstart = -1
-- opt.foldenable = true

-- Copilot
-- cmd [[
--     imap <silent><script><expr> <C-s> copilot#Accept("\<CR>")
--     let g:copilot_no_tab_map = v:true
-- ]]

-- GUI
opt.guifont = "Fira_Code:h14"

if g.neovide then
  g.neovide_transparency = 0.9
  g.neovide_fullscreen = true
end

-- Load filetype.lua
g.do_filetype_lua = 1
g.did_load_filetypes = 0
