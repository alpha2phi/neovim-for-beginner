-- Remap leader and local leader to <Space>
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.termguicolors = true -- Enable colors in terminal
vim.o.hlsearch = false --Set highlight on search
vim.wo.number = true --Make line numbers default
vim.wo.relativenumber = true --Make relative number default
vim.o.mouse = "a" --Enable mouse mode
vim.o.breakindent = true --Enable break indent
vim.opt.undofile = true --Save undo history
vim.o.ignorecase = true --Case insensitive searching unless /C or capital in search
vim.o.smartcase = true
vim.o.updatetime = 250 --Decrease update time
vim.wo.signcolumn = "yes"
