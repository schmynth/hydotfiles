return {
  cmd = { 'clangd', '--background-index', '--compile-commands-dir=build' },
  filetypes = { 'cpp', 'h', 'c' },
  -- root_markers are needed for lsp to work
  root_markers = { '.git', 'buildAndLaunch.sh' }
}
