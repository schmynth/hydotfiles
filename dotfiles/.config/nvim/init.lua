-- disable netrw at the very start of your init.lua
-- for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.opt.expandtab = true
vim.opt.clipboard = "unnamedplus"

-- folding: Enable Tree-sitter folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = false -- don’t auto-fold by default

-- show line numbers
vim.cmd("set number")

-- sets leader character for key mappings
vim.g.mapleader = " "

require("config.lsp")
require("sebastian.plugins")
-- require("sebastian.themes")
local toggleterm = require("sebastian.toggleterm")
toggleterm.setup_keymaps()

local myHarpoon = require("sebastian.harpoon")
myHarpoon.setup_keymaps()

require("sebastian.keymaps")

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = { "cpp", "lua", "python", "hyprlang", "css", "csv", "c", "bash" },
  highlight = { enable = true },
  indent = { enable = true },
})

require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

vim.lsp.enable({ 'clangd', 'lua_ls', 'pylsp' })

require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})
