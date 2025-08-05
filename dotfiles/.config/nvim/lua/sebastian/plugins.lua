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
  {"mbbill/undotree", cmd = "UndotreeToggle", },
  {"neovim/nvim-lspconfig",
    config = function() require("lspconfig").clangd.setup({}) end,},
  {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "neovim/nvim-lspconfig",
  },
  config = function()
    local cmp = require("cmp")
    cmp.setup({
      sources = {
        { name = "nvim_lsp" },
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
      }),
    })

    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    require("lspconfig").clangd.setup({
      capabilities = capabilities,
    })
  end,
}
}

local opts = {}

require("lazy").setup(plugins, opts)
