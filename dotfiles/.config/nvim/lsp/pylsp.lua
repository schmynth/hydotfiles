return {
  cmd = { "pylsp" }, -- Uses system-installed pylsp
  filetypes = { "py", "python" },
  -- root_markers are needed for lsp to work
  root_markers = { '.git', 'venv', '.venv' },
  -- root_dir = function(fname)
  --   return require("lspconfig.util").find_git_ancestor(fname)
  --       or vim.fn.getcwd()
  -- end,
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          enabled = true,
          maxLineLength = 100,
          ignore = { "E501" },
        },
        pylint = { enabled = false },
        black = { enabled = false },
        yapf = { enabled = false },
        pyls_isort = { enabled = true },
        rope_completion = { enabled = true },
      },
    },
  },
}
