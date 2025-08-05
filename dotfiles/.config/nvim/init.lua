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

local builtin = require("telescope.builtin")
local harpoon = require("harpoon")

harpoon:setup()
-- set keymaps
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)

vim.keymap.set("n", "<leader>fh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

vim.keymap.set("n", "<M-1>", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<M-2>", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<M-3>", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<M-4>", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<M-5>", function() harpoon:list():select(5) end)
vim.keymap.set("n", "<M-6>", function() harpoon:list():select(6) end)

vim.keymap.set("n", "<C-S-P>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-S-P>", function() harpoon:list():next() end)

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
  hidden = true
})

-- Toggle terminal with <C-t>
vim.keymap.set("n", "<C-t>", function()
  bottom_term:toggle()
end, { desc = "Toggle bottom terminal" })

-- Run ./build.sh in the same terminal with <leader>b
vim.keymap.set("n", "<F5>", function()
  if not bottom_term:is_open() then
    bottom_term:toggle()  -- open it if not already
  end
  bottom_term:send("./buildAndLaunch.sh\n", true)
end, { desc = "Run buildAndLaunch.sh in bottom terminal" })
