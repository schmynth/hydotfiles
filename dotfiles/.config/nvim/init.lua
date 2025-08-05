vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- show line numbers
vim.cmd("set number")

-- sets leader character for key mappings
vim.g.mapleader = " "


-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- installed plugins
local plugins = {
  { "catppuccin/nvim", name= "catppuccin", priority = 1000 },
  { 
	  'nvim-telescope/telescope.nvim', tag = '0.1.5',
    dependencies = { 'nvim-lua/plenary.nvim' }
	},
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "ThePrimeagen/harpoon", branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" }
	},
  {'akinsho/toggleterm.nvim', version = "*", config = true},
}

local opts = {}

require("lazy").setup(plugins, opts)

-- harpoon setup

local builtin = require("telescope.builtin")
local harpoon = require("harpoon")

harpoon:setup()
-- set keymaps
local ui = require("harpoon.ui")

local header = harpoon:list("header")
local implementation = harpoon:list("implementation")

-- adding files to 
-- Lists
vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
vim.keymap.set("n", "<leader>ah", function() harpoon:list("header"):add() end)
vim.keymap.set("n", "<leader>ai", function() harpoon:list("implementation"):add() end)
vim.keymap.set("n", "<leader>ad", function() harpoon:list("documentation"):add() end)

-- general menu
vim.keymap.set("n", "<leader>fh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

-- specific menus

vim.keymap.set("n", "<leader>hh<M-1>", function() harpoon:list("header"):select(1) end)
vim.keymap.set("n", "<leader>hh<M-2>", function() harpoon:list("header"):select(2) end)
vim.keymap.set("n", "<leader>hh<M-3>", function() harpoon:list("header"):select(3) end)
vim.keymap.set("n", "<leader>hh<M-4>", function() harpoon:list("header"):select(4) end)
vim.keymap.set("n", "<leader>hh<M-5>", function() harpoon:list("header"):select(5) end)
vim.keymap.set("n", "<leader>hh<M-6>", function() harpoon:list("header"):select(6) end)
vim.keymap.set("n", "<leader>hi<M-1>", function() harpoon:list("implementation"):select(1) end)
vim.keymap.set("n", "<leader>hi<M-2>", function() harpoon:list("implementation"):select(2) end)
vim.keymap.set("n", "<leader>hi<M-3>", function() harpoon:list("implementation"):select(3) end)
vim.keymap.set("n", "<leader>hi<M-4>", function() harpoon:list("implementation"):select(4) end)
vim.keymap.set("n", "<leader>hi<M-5>", function() harpoon:list("implementation"):select(5) end)
vim.keymap.set("n", "<leader>hi<M-6>", function() harpoon:list("implementation"):select(6) end)
vim.keymap.set("n", "<leader>hd<M-1>", function() harpoon:list("documentation"):select(1) end)
vim.keymap.set("n", "<leader>hd<M-2>", function() harpoon:list("documentation"):select(2) end)
vim.keymap.set("n", "<leader>hd<M-3>", function() harpoon:list("documentation"):select(3) end)
vim.keymap.set("n", "<leader>hd<M-4>", function() harpoon:list("documentation"):select(4) end)
vim.keymap.set("n", "<leader>hd<M-5>", function() harpoon:list("documentation"):select(5) end)
vim.keymap.set("n", "<leader>hd<M-6>", function() harpoon:list("documentation"):select(6) end)
vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<M-5>", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<M-6>", function() harpoon:list():select(6) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():next() end)

-- for named UI:
local function open_named_ui(group_name)
  local list = require("harpoon"):list(group_name)


  require("harpoon").ui:toggle_quick_menu(list, {
  title = "📁 Harpoon Group: " .. group_name
  })
end

vim.keymap.set("n", "<leader>hh", function() open_named_ui("header") end)
vim.keymap.set("n", "<leader>hi", function() open_named_ui("implementation") end)
vim.keymap.set("n", "<leader>hd", function() open_named_ui("documentation") end)

-- find files
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- grep files
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})

local config = require("nvim-treesitter.configs")
config.setup({
  ensure_installed = {"cpp", "lua", "python", "hyprlang", "css", "csv", "c", "bash"},
  highlight = { enable = true },
  indent = { enable = true },
})



require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

require("toggleterm").setup({
  size = 15,
  open_mapping = [[<C-t>]],  -- Ctrl+t toggles terminal at the bottom
  direction = "horizontal",
  shade_terminals = true,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  close_on_exit = false,
})

-- Create a persistent terminal instance at the bottom
local Terminal = require("toggleterm.terminal").Terminal

-- This will be your bottom terminal
local bottom_term = Terminal:new({
  direction = "horizontal",
  hidden = true,
  close_on_exit = false,
  on_open = function(term)
  vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<C-t>", "<cmd>lua _toggle_bottom_term()<CR>", { noremap = true, silent = true })
  end,
})

function _toggle_bottom_term()
  bottom_term:toggle()
end

-- Toggle terminal with <C-t>
vim.keymap.set({"n", "t"}, "<C-t>", _toggle_bottom_term, { desc = "Toggle bottom terminal" })

-- Run ./build.sh in the same terminal with <leader>b
vim.keymap.set("n", "<F5>", function()
  if not bottom_term:is_open() then
    bottom_term:toggle()  -- open it if not already
  end
  bottom_term:send("./buildAndLaunch.sh\n", true)
end, { desc = "Run buildAndLaunch.sh in bottom terminal" })
